require File.dirname(__FILE__) + '/../test_helper'

class DNFLexerTest < DNFTranslator::TestCase

  def test_lex_an_empty_string
    lexer = DNFTranslator::Parser::DNFLexer.new(" ")
    assert_nil lexer.read_next_token_if_a_literal_or_phrase
  end

  def test_lex_a_sequence_of_spaces_separated_literals
    lexer = DNFTranslator::Parser::DNFLexer.new("one two three")
    assert_equal "one",   lexer.read_next_token_if_a_literal_or_phrase.to_s
    assert_equal "two",   lexer.read_next_token_if_a_literal_or_phrase.to_s
    assert_equal "three", lexer.read_next_token_if_a_literal_or_phrase.to_s
    assert_nil lexer.read_next_token_if_a_literal_or_phrase
  end

  def test_lex_words_grouped_between_simple_quotes
    lexer = DNFTranslator::Parser::DNFLexer.new(" 'ab cd'")
    assert_equal "'ab cd'", lexer.read_next_token_if_a_literal_or_phrase.to_s
    assert_nil lexer.read_next_token_if_a_literal_or_phrase
  end

  def test_lex_words_grouped_between_double_quotes
    lexer = DNFTranslator::Parser::DNFLexer.new('"ab cd"')
    assert_equal '"ab cd"', lexer.read_next_token_if_a_literal_or_phrase.to_s
    assert_nil lexer.read_next_token_if_a_literal_or_phrase
  end
end
