require File.dirname(__FILE__) + '/../test_helper'

class ParserIncludesTest <  Test::Unit::TestCase

#-------------
# Nested parenthesis
#-------------

  def test_nested_parenthesis_with_AND
    check_parsing "((one))"                      , [LIT_ONE]
    check_parsing "((one two))"                  , [AND_ONE_TWO]
    check_parsing "((one two) three )"           , [and_expr(AND_ONE_TWO, LIT_THREE     )]
    check_parsing "(one (three four) )"          , [and_expr(LIT_ONE    , AND_THREE_FOUR)]
    check_parsing "((one two)(three four) )"     , [and_expr(AND_ONE_TWO, AND_THREE_FOUR)]
    check_parsing "((one two)(three four) five)" , [and_expr(AND_ONE_TWO, AND_THREE_FOUR, LIT_FIVE )]
  end

  def test_nested_parenthesis_with_AND_in_AND
    check_parsing "((one two)(three four)) five", [and_expr(and_expr(AND_ONE_TWO, AND_THREE_FOUR), LIT_FIVE )]
  end

  def test_nested_parenthesis_with_outer_exclusion
    check_parsing "-((one))"              , [], [LIT_ONE]
    check_parsing "((-one))"              , [], [LIT_ONE]
    check_parsing "-((one two))"          , [], [AND_ONE_TWO]
    check_parsing "-((one two) three )"   , [], [and_expr(AND_ONE_TWO, LIT_THREE     )]
  end

  def test_nested_parenthesis_with_OR
    check_parsing "(one|two)"             ,[or_expr( LIT_ONE, LIT_TWO)]
    check_parsing "(one |(two) )"         ,[OR_ONE_TWO]
    check_parsing "(one|two)|(three|four)",[or_expr( OR_ONE_TWO, OR_THREE_FOUR)]
    check_parsing "((one two)|three )"    ,[or_expr( AND_ONE_TWO, LIT_THREE)]
  end

  def test_nested_parenthesis_with_OR_with_inner_ORs
    check_parsing "(one|two)|(three|four)", [or_expr( OR_ONE_TWO, OR_THREE_FOUR)]
  end

  def test_nested_parenthesis_AND_with_inner_ORs
    check_parsing "(one|two) three"      , [and_expr(OR_ONE_TWO, LIT_THREE)]
    check_parsing "three (one|two)"      , [and_expr(LIT_THREE, OR_ONE_TWO)]
    check_parsing "(one|two)(three|four)", [and_expr(OR_ONE_TWO, OR_THREE_FOUR)]
  end

  def test_nested_parenthesis_OR_with_inner_ANDs
    check_parsing "(one |(three four) )"     , [or_expr(LIT_ONE, AND_THREE_FOUR)]
    check_parsing "((one two)|three )"       , [or_expr( AND_ONE_TWO, LIT_THREE)]
    check_parsing "((one two)|(three four) )", [or_expr(AND_ONE_TWO, AND_THREE_FOUR)]
  end

  def test_nested_parenthesis_3
    check_parsing "((one two)) -three", [AND_ONE_TWO], [LIT_THREE]
  end

#-------------
# Empty expression
#-------------

  def test_empty_parens
    check_parsing "()"  , []
    check_parsing " ( )", []
  end

#-------------
# Literals
#-------------

  def test_one_word
    check_parsing "one",     [LIT_ONE]
    check_parsing "  one  ", [LIT_ONE]
  end

  def test_one_word_between_parens
    check_parsing " ( one ) ", [LIT_ONE]
  end

  def test_simple_string_wrapped_in_useless_parens
    check_parsing "(one)"  , [LIT_ONE]
    check_parsing "( one )", [LIT_ONE]
  end

  def test_one_word_with_inner_dots
    check_parsing '"a.b.c"', [Element::Literal.new('"a.b.c"')]
    check_parsing "'a.b.c'", [Element::Literal.new("'a.b.c'")]
  end

  def test_two_words_between_1_pair_of_quotes
    quoted_two_words = "'one two'"
    check_parsing quoted_two_words, [Element::Phrase.new(quoted_two_words)]
  end

  def test_one_word_starting_with_a_hash
    expected_literal = Element::Literal.new('#hash')
    check_parsing "#hash", [expected_literal]
  end

  def test_one_word_starting_with_a_hash_between_quotes
    check_parsing "'#hash'", [Element::Literal.new("'#hash'")]
  end

#-------------
# ANDs
#-------------

  def test_two_or_three_words
    check_parsing "one two"      , [and_expr(LIT_ONE, LIT_TWO)]
    check_parsing "one two three", [and_expr(LIT_ONE, LIT_TWO, LIT_THREE)]
  end

  def test_all_types_of_literals_in_one_string
    lit_1 = Element::Literal.new('a.b.c')
    lit_2 = Element::Literal.new('#hash')
    check_parsing "a.b.c #hash", [and_expr(lit_1, lit_2)]
  end


  def test_two_words_in_parens
    check_parsing "(one two)", [AND_ONE_TWO]
  end

  def test_twice_two_words_in_parens
    check_parsing "(one two) (three four) five", [and_expr(AND_ONE_TWO, AND_THREE_FOUR, LIT_FIVE)]
  end

#-------------
# ORs
#-------------
  def test_1_OR
    check_parsing " ( one | two ) ", [OR_ONE_TWO]
    check_parsing "(one|two|three)", [OR_ONE_TWO_THREE]
  end

  def test_1_OR_with_1_literal_exclusion
    check_parsing " (-one|two)", [OR_NOT_ONE_TWO]
  end


  def test_2_ORs
    check_parsing "(one|two) (three|four)", [and_expr(OR_ONE_TWO,OR_THREE_FOUR)]
  end


#-------------
# Complex Combinations
#-------------

  def test_AND_1_OR_group_followed_by_1_literal
    check_parsing "(one | two) three", [and_expr(OR_ONE_TWO,LIT_THREE)]
  end

  def test_AND_1_literal_followed_by_1_OR_group
    check_parsing "-one (three| four)", [OR_THREE_FOUR], [LIT_ONE]
  end

  def test_AND_2_ORs_groups_plus_1_literal
    check_parsing "(one | two) (three| four) five", [and_expr(OR_ONE_TWO, OR_THREE_FOUR, LIT_FIVE)]
  end

  def test_OR_2_1_AND_groups_and_1_literal
    check_parsing "(one two) | three", [or_expr(AND_ONE_TWO, LIT_THREE)]
  end

  def test_OR_2_AND_groups_plus_1_literal
    check_parsing "(one two) | (three four) | five", [or_expr(AND_ONE_TWO, AND_THREE_FOUR, LIT_FIVE)]
  end

#-------------
# Syntax Errors
#-------------

  def test_syntax_error
    assert_syntax_error_in "( |)"
    assert_syntax_error_in "( -)"
    assert_syntax_error_in "( a | b c)"
   #assert_syntax_error_in "one | two five"
  end

  def test_syntax_error_1
    assert_syntax_error_in "(|)"
  end

  def test_syntax_error_2
    assert_syntax_error_in "one | | two"
  end

  def test_syntax_error_3
    assert_syntax_error_in ")"
    assert_syntax_error_in ")("
    assert_syntax_error_in ")()"
    assert_syntax_error_in "(one))"
  end

  def test_syntax_error_4
    assert_syntax_error_in "-"
    assert_syntax_error_in "--"
    assert_syntax_error_in "--one"
    assert_syntax_error_in "(one)-"
    assert_syntax_error_in "one-"
    assert_syntax_error_in "|-"
    assert_syntax_error_in "-|"
    assert_syntax_error_in "(-(one))"
  end

end
