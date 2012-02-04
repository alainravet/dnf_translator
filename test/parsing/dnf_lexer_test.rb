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

  # IS THE SAME AS:

    source = "one two three"
    expected = ['one', 'two', 'three', nil]
    check_lexed_literals_or_phrases_are expected, :source => source
  end


  def test_lex_a_sequence_of_spaces_separated_literals_each_prefixed_by_minus
    source    = "-one -two -three"
    expected  = ['-one', '-two', '-three', nil]
    check_lexed_literals_or_phrases_are expected, :source => source
  end

  def test_lex_words_grouped_between_quotes
    source    = " 'ab cd' 'ef gh'"
    expected  = ["'ab cd'", "'ef gh'", nil]
    check_lexed_literals_or_phrases_are expected, :source => source

    source    = ' "ab cd" "ef gh"'
    expected  = ['"ab cd"', '"ef gh"', nil]
    check_lexed_literals_or_phrases_are expected, :source => source
  end


  def test_lex_individual_words_prefixed_by_minus
    source    = " -ab -cd"
    expected  = ["-ab", "-cd", nil]
    check_lexed_literals_or_phrases_are expected, :source => source
  end

  def test_lex_individual_words_prefixed_by_minus_between_quotes
    source    = " -ab -'cd' -'ef gh'"
    expected  = ["-ab", "-'cd'", "-'ef gh'", nil]
    check_lexed_literals_or_phrases_are expected, :source => source

    source    = ' -ab -"cd" '
    expected  = ["-ab", '-"cd"', nil]
    check_lexed_literals_or_phrases_are expected, :source => source
  end

end
