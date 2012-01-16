require 'forwardable'

module DNFTranslator::Base

  class Lexer
    attr_reader :string_scanner

    def initialize(text)
      @string_scanner = StringScanner.new(text)
    end

  # ------------------------------------------------------------------------------

    extend ::Forwardable
    def_delegator :@string_scanner, :pos

  # ------------------------------------------------------------------------------

  protected
    def read_next_token_if_it_matches(pattern)
      @string_scanner.scan(pattern)
    end

    def next_token_matches?(pattern)
      @string_scanner.match?(pattern)
    end

    def eat_spaces
      @string_scanner.scan /\s*/
    end
  end

end
