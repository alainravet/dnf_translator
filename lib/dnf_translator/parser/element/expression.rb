require File.dirname(__FILE__) + "/../../base/values_container"
module DNFTranslator::Parser
  module Element

    class Expression
      include DNFTranslator::Base::ValuesContainer
      include DNFTranslator::Parser # for Element

      def simplified
        case @values.length
          when 0 then nil
          when 1 then Element::Literal.new(@values.first)
          else        self
        end
      end

    end

  end
end
