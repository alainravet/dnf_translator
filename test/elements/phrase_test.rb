require File.dirname(__FILE__) + '/../test_helper'

class PhraseTest <  DNFTranslator::TestCase

  include DNFTranslator::Parser

  def test_equality
    assert_equal Element::Phrase.new('a b c'),
                 Element::Phrase.new('a b c')
  end

  def test_inequality
    assert_not_equal Element::Phrase.new('a b c'),
                     Element::Phrase.new('a b c ')
  end
end
