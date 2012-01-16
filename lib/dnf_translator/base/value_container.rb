require 'forwardable'

module DNFTranslator::Base

  module ValueContainer
    attr_reader :value

    def initialize(value)
      @value     = value
    end

  # ------------------------------------------------------------------------------

    extend Forwardable
    def_delegators :value, :to_s, :inspect

  # ------------------------------------------------------------------------------
    def ==(other)
      other.value == self.value
    end
  end

end
