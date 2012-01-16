require File.dirname(__FILE__) + '/../test_helper'

class AndExpressionTest < Test::Unit::TestCase
  include DNFTranslator::Parser
  def setup
    @a = Element::Literal.new( 'a')
    @b = Element::Literal.new( 'b')
  end

  def test_value
    exp = Element::AndExpression.new(@a, @b)
    assert_equal [@a, @b], exp.values
  end

  def test_push
    exp = Element::AndExpression.new()
    exp << @a << @b
    assert_equal [@a, @b], exp.values

  end
end