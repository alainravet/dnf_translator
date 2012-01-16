class DNFTranslator::Parser::DNFExpressionParser
  include DNFTranslator::Parser # for Element::*

  def initialize(text)
    @text  = text
    @lexer = DNFTranslator::Parser::DNFLexer.new(text)
  end

  def parse
    raw_elems_required, raw_elems_forbidden = lex_and_preparse

    DNFTranslator::Parser::ParsingResults.new.tap do |results|
      case raw_elems_required.size
        when 0
        when 1
          results.elems_required << raw_elems_required.first
        else
          is_or_expr = raw_elems_required.include?(Element::OrOperator::INSTANCE)
          results.elems_required << ( is_or_expr ?
              Element::OrExpression .new(*raw_elems_required) :
              Element::AndExpression.new(*raw_elems_required)
            )
      end

      raw_elems_forbidden.each do |item|
        #store excluded items are stored in their positive form in stack.items_excluded :
        item.absolufy! if item.is_a?(Element::Literal)
      end
      case raw_elems_forbidden.size
        when 0
        when 1
          results.elems_forbidden << raw_elems_forbidden.first
        else
          results.elems_forbidden << Element::OrExpression.new(*raw_elems_forbidden)
      end
    end
  end

  def lex_and_preparse
    @raw_elems_required, @raw_elems_forbidden = [], []
    @parens_level = 0
    catch(:stop_parsing) do
      state = :start
      loop do
        if [:start, :after_parens_expr, :after_literal].include?(state)
          if match = find_parenthesized_expression || find_parenthesized_expression(minus_before_parens=true)
            state  = :after_parens_expr
            store_found_element(match, must_exclude_found_element?(match))

          elsif match = find_literal
            state  = :after_literal
            store_found_element(match, must_exclude_found_element?(match))

          elsif match = find_OR_operator
            state  = :after_OR_operator
            store_found_element(match, must_exclude_found_element?(match))

          elsif @lexer.string_scanner.rest.strip.size==0
            throw(:stop_parsing) unless match
          else
            #raise SyntaxError.new("in #{@text} at position #{@lexer.pos}")
            raise SyntaxError.new("#{@lexer.string_scanner.rest.strip.inspect}")
          end

        elsif [:after_OR_operator].include?(state)
          if match = find_parenthesized_expression || find_parenthesized_expression(minus_before_parens=true)
            state  = :after_parens_expr
            store_found_element(match, must_exclude_found_element?(match))

          elsif match = find_literal
            state  = :after_literal
            store_found_element(match, must_exclude_found_element?(match))
          else
            raise SyntaxError.new("in #{@text} at position #{@lexer.pos}")
          end
        end

      end
    end
    [@raw_elems_required, @raw_elems_forbidden]
  end

  def store_found_element(match, must_exclude_found_element)
    if must_exclude_found_element
      @raw_elems_forbidden << match
    else
      @raw_elems_required<< match
    end
  end

  def must_exclude_found_element?(match)
    @minus_mode || (match.is_a?(Element::Literal) && match.starts_with_minus?)
  end


#------------------------------------------------------------------------------------------
private

#------------------------------------------------------------------------------------------
  def find_OR_operator
    Element::OrOperator::INSTANCE if @lexer.read_next_token_if_OR_separator
  end

  def find_literal
    @lexer.read_next_token_if_a_literal_or_phrase
  end

  def find_literal_or_parenthesized_expression(minus_before_parens=false)
    res = find_literal
    res ||= find_parenthesized_expression(minus_before_parens)
    res
  end


  def find_parenthesized_expression(minus_before_parens=false)
    @lexer.skip_empty_parens
    unless @lexer.read_next_token_if_open_parenthesis(minus_before_parens)
      return false
    end
    @parens_level += 1
    @minus_mode   =  false
    first_part = find_literal_or_parenthesized_expression

    unless first_part  # parens contents start is not a word => error
      raise SyntaxError.new("in #{@text} at position #{@lexer.pos}")
    end

    @minus_mode =  minus_before_parens
    find_OR_operator ?
      extract_OR_expression(first_part) :
      extract_AND_expression(first_part)
  end

#------------------------------------------------------------------------------------------

  def extract_AND_expression(first_word)
    tokens = [first_word]
    while word = find_literal_or_parenthesized_expression do
      tokens << word
    end

    if tokens.size == 1
      @lexer.read_next_token_if_close_parenthesis! # consume the closing parenth. in  "( one )"
      tokens.first
    elsif @lexer.next_token_is_close_parenthesis?
      @lexer.read_next_token_if_close_parenthesis
      if @parens_level ==1
        @lexer.read_next_token_if_close_parenthesis # consume the closing parenth. in  "( one (three four)"
      end
      Element::AndExpression.new(*tokens)
    else
      raise SyntaxError::CLOSING_PARENTHESIS_NOT_FOUND
    end
  end

  def extract_OR_expression(first_word)
    tokens = [first_word]
    begin
      if word = find_literal_or_parenthesized_expression
        tokens << word
      end
    end while(find_OR_operator)
    if @lexer.read_next_token_if_close_parenthesis
      Element::OrExpression.new(*tokens).simplified
    else
      raise SyntaxError::CLOSING_PARENTHESIS_NOT_FOUND
    end
  end

end
