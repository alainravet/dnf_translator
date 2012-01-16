require "strscan"

module DNFTranslator
  module Parser
    class SyntaxError < RuntimeError
      CLOSING_PARENTHESIS_NOT_FOUND = new("')' not found ")
    end
  end
end

require File.dirname(__FILE__) + "/base"
Dir[File.join(File.dirname(__FILE__), "parser","**","*.rb")].each {|f| require f}