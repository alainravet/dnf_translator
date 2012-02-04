require File.dirname(__FILE__) + "/../../base/value_container"

module DNFTranslator::Parser
  module Element

    class Phrase
      include DNFTranslator::Base::ValueContainer

      def starts_with_minus?
        @value.start_with?('-')
      end

      def absolufy!
        @value = value_abs(@value)
        self
      end

      def value_abs(value)
        starts_with_minus? ?
            value[1..-1] :  # remove 1st char
            value
      end
    end

  end
end
