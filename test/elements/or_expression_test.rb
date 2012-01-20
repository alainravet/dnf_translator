require File.dirname(__FILE__) + '/../test_helper'

class OrExpressionTest < DNFTranslator::TestCase
  include DNFTranslator::Parser
  def setup
    @a = Element::Literal.new( 'a')
    @b = Element::Literal.new( 'b')
  end

  def test_value
    exp = Element::OrExpression.new(@a, @b)
    assert_equal [@a, @b], exp.values
  end

  def test_push
    exp = Element::OrExpression.new
    exp << @a << @b
    assert_equal [@a, @b], exp.values
  end

  def test_equality
    assert_equal Element::OrExpression.new(Element::Literal.new( 'a'), Element::Literal.new( 'b')),
                 Element::OrExpression.new(Element::Literal.new( 'a'), Element::Literal.new( 'b'))
  end

  def test_inequality
    assert_not_equal Element::OrExpression.new(Element::Literal.new( 'a'), Element::Literal.new( 'b')),
                     Element::OrExpression.new(Element::Literal.new( 'a'), Element::Literal.new( 'a'))
  end
end