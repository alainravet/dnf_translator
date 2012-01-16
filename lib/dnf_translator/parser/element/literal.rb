require File.dirname(__FILE__) + "/../../base/value_container"

module DNFTranslator::Parser
  module Element

    class Literal
      include DNFTranslator::Base::ValueContainer

      def starts_with_minus?
        @value.start_with?('-')
      end

      def absolufy!
        @value = value_abs(@value)
        self
      end

      def value_abs(remove_outer_quotes_if_single_word=false)
        val = starts_with_minus? ?
            @value[1..-1] :
            @value
        if !remove_outer_quotes_if_single_word || !(val =~ DNFTranslator::Parser::Pattern::QUOTED_SINGLEWORD_LITERAL_PATTERN)
          val
        else
          val[1..-2]
        end
      end

    end

  end
end
