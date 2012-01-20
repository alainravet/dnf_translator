# see acceptance_test.rb for more translation tests.

require File.dirname(__FILE__) + '/../test_helper'

class TranslationToEnglishTest <  DNFTranslator::TestCase

  def test_translate_1_literal
    assert_translation_is "one", :source => "one"
  end

  def test_sequence_of_literals
    assert_translation_is "one AND two AND three", :source => "one two three"
  end

  def test_simple_flat_exclusion
    assert_translation_is "a AND no mention of b", :source => "a -b"
  end

  def test_simple_flat_exclusion_inversed
    assert_translation_is "a AND no mention of b", :source => "-b a"
  end

  def test_double_flat_exclusion
    assert_translation_is "a AND no mention of b OR c", :source => "a -b -c"
  end

end
