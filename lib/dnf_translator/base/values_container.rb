require 'forwardable'

module DNFTranslator::Base

  module ValuesContainer
    attr_reader :values

    def initialize(*elements)
      @values     = elements.dup
    end

  # ------------------------------------------------------------------------------

    extend Forwardable
    def_delegators :@values, :<<

  # ------------------------------------------------------------------------------

    def ==(other)
      other.is_a?(self.class) && other.values== self.values
    end
  end

end
