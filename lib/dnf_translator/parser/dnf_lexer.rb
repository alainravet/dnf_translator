require File.dirname(__FILE__) + "/../base/lexer"
require File.dirname(__FILE__) + "/pattern"

class DNFTranslator::Parser::DNFLexer < DNFTranslator::Base::Lexer
  include DNFTranslator::Parser

  def skip_empty_parens
    while read_next_token_if_it_matches(Pattern::EMPTY_PARENS_PATTERN) do
    end
  end

  def read_next_token_if_open_parenthesis(minus_before_parens=false)
    if minus_before_parens
      read_next_token_if_minus_open_parenthesis
    else
      read_next_token_if_it_matches Pattern::START_PARENS_PATTERN
    end

  end

  def read_next_token_if_minus_open_parenthesis
    read_next_token_if_it_matches Pattern::MINUS_START_PARENS_PATTERN
  end

  def read_next_token_if_close_parenthesis
    read_next_token_if_it_matches(Pattern::END_PARENS_PATTERN)
  end

  def read_next_token_if_close_parenthesis!
    raise SyntaxError::CLOSING_PARENTHESIS_NOT_FOUND unless next_token_is_close_parenthesis?
    read_next_token_if_it_matches(Pattern::END_PARENS_PATTERN)
  end

  def read_next_token_if_OR_separator
    read_next_token_if_it_matches(Pattern::OR_EXPRESSION_SEPARATOR_PATTERN)
  end

  def next_token_is_close_parenthesis?
    next_token_matches? Pattern::END_PARENS_PATTERN
  end

  def read_next_token_if_a_literal_or_phrase
    eat_spaces
    if read_next_token_if_it_matches(Pattern::QUOTED_MULTIWORDS_PHRASE_PATTERN)
      Element::Phrase.new(@string_scanner.matched)
    elsif read_next_token_if_it_matches(Pattern::QUOTED_SINGLEWORD_LITERAL_PATTERN)
      Element::Literal.new(@string_scanner.matched.strip)
    elsif read_next_token_if_it_matches(Pattern::UNQUOTED_LITERAL_PATTERN)
      Element::Literal.new(@string_scanner.matched.strip)
    end
  end

end
