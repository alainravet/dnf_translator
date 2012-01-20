require File.dirname(__FILE__) + '/../lib/dnf_translator'
require File.dirname(__FILE__) + '/../lib/dnf_translator/test_case'


LIT_ONE           = DNFTranslator::Parser::Element::Literal.new(  'one')
LIT_not_ONE       = DNFTranslator::Parser::Element::Literal.new( '-one')
LIT_not_TWO       = DNFTranslator::Parser::Element::Literal.new( '-two')
LIT_TWO           = DNFTranslator::Parser::Element::Literal.new(  'two')
LIT_THREE         = DNFTranslator::Parser::Element::Literal.new('three')
LIT_FOUR          = DNFTranslator::Parser::Element::Literal.new( 'four')
LIT_FIVE          = DNFTranslator::Parser::Element::Literal.new( 'five')

AND_ONE_TWO       = DNFTranslator::Parser::Element::AndExpression.new(LIT_ONE,    LIT_TWO)
AND_THREE_FOUR    = DNFTranslator::Parser::Element::AndExpression.new(LIT_THREE,  LIT_FOUR)
OR_ONE_TWO        = DNFTranslator::Parser::Element::OrExpression.new(LIT_ONE,     LIT_TWO)
OR_NOT_ONE_TWO    = DNFTranslator::Parser::Element::OrExpression.new(LIT_not_ONE, LIT_TWO)
OR_ONE_TWO_THREE  = DNFTranslator::Parser::Element::OrExpression.new(LIT_ONE,     LIT_TWO, LIT_THREE)
OR_THREE_FOUR     = DNFTranslator::Parser::Element::OrExpression.new(LIT_THREE,   LIT_FOUR)
