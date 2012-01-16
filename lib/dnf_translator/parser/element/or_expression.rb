require File.dirname(__FILE__) + "/expression"

module DNFTranslator::Parser::Element

  class OrExpression < Expression

    def initialize(*elems)
      elems.reject!{|el| el.is_a?(Element::OrOperator)}
      super(*elems)
    end
  end

end
