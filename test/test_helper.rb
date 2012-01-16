require File.dirname(__FILE__) + '/../lib/dnf_translator'
require 'rubygems'
require 'test/unit'

include DNFTranslator::Parser


def check_parsing(source_string, expected_required_values, expected_forbidden_values = [])
  @stack = DNFTranslator::Parser::DNFExpressionParser.new(source_string).parse
  unless @stack == DNFTranslator::Parser::ParsingResults.new(expected_required_values, expected_forbidden_values )
    assert_equal expected_required_values , @stack.elems_required,  "REQUIRED VALUES ERROR"
    assert_equal expected_forbidden_values, @stack.elems_forbidden, "EXCLUDED VALUES ERROR"
  end
end

def assert_translation_is(expected_translation, params)
  assert_equal expected_translation,
               DNFTranslator::English.translate(params[:source])
end

def assert_syntax_error_in(source_string)
  assert_raise DNFTranslator::Parser::SyntaxError do
    DNFTranslator::Parser::DNFExpressionParser.new(source_string).parse
  end
end

def and_expr(*elements)
  Element::AndExpression.new *Array(elements)
end

def or_expr(*elements)
  Element::OrExpression.new *Array(elements)
end

LIT_ONE           = Element::Literal.new(  'one')
LIT_not_ONE       = Element::Literal.new( '-one')
LIT_not_TWO       = Element::Literal.new( '-two')
LIT_TWO           = Element::Literal.new(  'two')
LIT_THREE         = Element::Literal.new('three')
LIT_FOUR          = Element::Literal.new( 'four')
LIT_FIVE          = Element::Literal.new( 'five')

AND_ONE_TWO       = Element::AndExpression.new(LIT_ONE,    LIT_TWO)
AND_THREE_FOUR    = Element::AndExpression.new(LIT_THREE,  LIT_FOUR)
OR_ONE_TWO        = Element::OrExpression.new(LIT_ONE,     LIT_TWO)
OR_NOT_ONE_TWO    = Element::OrExpression.new(LIT_not_ONE, LIT_TWO)
OR_ONE_TWO_THREE  = Element::OrExpression.new(LIT_ONE,     LIT_TWO, LIT_THREE)
OR_THREE_FOUR     = Element::OrExpression.new(LIT_THREE,   LIT_FOUR)
