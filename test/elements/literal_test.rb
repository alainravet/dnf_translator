require File.dirname(__FILE__) + '/../test_helper'

class LiteralTest <  Test::Unit::TestCase

  def test_equality
    assert_equal Element::Literal.new('one'),
                 Element::Literal.new('one')
  end

  def test_inequality
    #basics
    assert_not_equal  Element::Literal.new('two'),
                      Element::Literal.new('one')
    # is quote sensitive
    assert_not_equal  Element::Literal.new('"one"'),
                      Element::Literal.new('one')
  end

end
