require File.dirname(__FILE__) + '/../test_helper'
class AcceptanceTest <  DNFTranslator::TestCase

  def test_1
    assert_translation_is   'a OR b OR c AND no mention of d OR e'                  , :source =>   '(a | b | c) -(d | e)'
  end

  def test_2
    assert_translation_is   'a OR b OR c AND no mention of d OR e'                   , :source =>   '(a | b |c) -d -e'
  end

  def test_3
    assert_translation_is   'a OR b OR c AND no mention of the phrase "d e"'         , :source =>   '(a | b | c) -("d e")'
  end

  def test_4
    assert_translation_is   'a AND b OR c AND d OR e AND f'                          , :source =>   '(a b) | (c d) | (e f)'
  end

  def test_5
    assert_translation_is   'the phrase "a b" OR the phrase "c d" OR the phrase "e f"',:source =>   '"a b" | "c d" | "e f"'
  end

  def test_6
    assert_translation_is   'a AND b OR c AND d OR e AND f AND no mention of 1 OR 2', :source =>   '((a b) | (c d) | (e f)) -(1 | 2)'
  end

  def test_7
    assert_translation_is   'the phrase "a b" OR the phrase "c d" OR the phrase "e f" AND no mention of the phrase "1 2" OR the phrase "3 4"',
                            :source =>   '("a b" | "c d" | "e f") -("1 2" | "3 4")'
  end

  def test_8
    # original request () PROBLEM : this is incompatible with test_3)
    # assert_translation_is   '(a b) OR (a c) OR (a d) OR (a e) OR (a f) AND no mentions of 1 OR 2 OR 3.', :source =>   'a (b | c | d | e | f) -(1 | 2 | 3)'
    assert_translation_is   "a AND b OR c OR d OR e OR f AND no mention of 1 OR 2 OR 3",
                            :source =>   'a (b | c | d | e | f) -(1 | 2 | 3)'
  end

  def test_9
    assert_translation_is   'a AND b AND no mention of c'                            , :source =>   '(a b) -c'
  end

  def test_10
    assert_translation_is   'a AND b AND no mention of c AND d'                      , :source =>   '(a b) -(c d)'
  end

  def test_11
    assert_translation_is   'a AND b OR the phrase "a c" OR a.com OR #b AND no mention of mac'  ,
                            :source =>   '(a b) | "a c" | "a.com" | "#b" -mac'
    assert_translation_is   'a AND b OR the phrase "a c" OR a.com OR #b AND no mention of mac'  ,
                            :source =>   '(a b) | "a c" | "a.com" | "#b" -(mac)'
  end

  def test_12_syntax_error
    assert_translation_is   "This is not a valid expression"  , :source => '-| b'
  end
end
