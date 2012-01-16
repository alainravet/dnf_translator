require 'forwardable'
class DNFTranslator::Parser::ParsingResults

  attr_reader :elems_required, :elems_forbidden

  def initialize
    @elems_required  = []
    @elems_forbidden = []
  end

# ------------------------------------------------------------------------------

  def ==(other)
    other.is_a?(DNFTranslator::Parser::ParsingResults)  \
    && other.elems_required  == self.elems_required   \
    && other.elems_forbidden == self.elems_forbidden
  end
end
