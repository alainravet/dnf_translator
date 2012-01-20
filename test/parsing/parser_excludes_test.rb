require File.dirname(__FILE__) + '/../test_helper'

class ParserExcludeTest <  DNFTranslator::TestCase

  def test_exclude_one_word
    check_parsing "-one"  , [], [LIT_ONE]
    check_parsing " -one ", [], [LIT_ONE]
  end

  def test_exclude_one_word_between_parens
    check_parsing "(-one)", [], [LIT_ONE]
  end

  def test_multiple_trailing_flat_excludes
    check_parsing "three -one"            , [LIT_THREE], [LIT_ONE]
    check_parsing "three -one -two"       , [LIT_THREE], [or_expr(LIT_ONE, LIT_TWO)]
    check_parsing "(three four) -one -two", [AND_THREE_FOUR], [or_expr(LIT_ONE, LIT_TWO)]
  end

  def test_1_trailing_grouped_single_exclude
    check_parsing "(three four) -(one)", [AND_THREE_FOUR], [LIT_ONE]
  end

  def test_1_trailing_grouped_double_exclude
    check_parsing "(three four) -(one two)", [AND_THREE_FOUR], [AND_ONE_TWO]
  end

  def test_trailing_grouped_double_exclude
    check_parsing "five -(one two) -(three four)", [LIT_FIVE], [or_expr(AND_ONE_TWO, AND_THREE_FOUR)]
  end

  def test_one_match_and_one_exclusion
    check_parsing "two -one", [LIT_TWO], [LIT_ONE]
  end

  def test_one_exclusion_and_one_match
    check_parsing "-one two", [LIT_TWO], [LIT_ONE]
  end

  def test_1_OR_with_1_literal_exclusion
    check_parsing " (-one|two)", [OR_NOT_ONE_TWO] ,[]
  end

  def test_flat_trailing_exclusions_are_ORed
    check_parsing "five -one -two", [LIT_FIVE], [or_expr(LIT_ONE, LIT_TWO)]
  end

  def test_flat_grouped_trailing_exclusions_are_ANDed
    check_parsing "five -(one two)", [LIT_FIVE], [and_expr(LIT_ONE, LIT_TWO)]
  end

  def test_flat_fand_grouped_trailing_exclusions_combined
    required = [LIT_FIVE]
    excluded = [or_expr(and_expr(LIT_ONE, LIT_TWO), and_expr(LIT_THREE, LIT_FOUR))]
    check_parsing "five -(one two) -(three four)", required, excluded
  end
end
