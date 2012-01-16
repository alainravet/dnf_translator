module DNFTranslator
  VERSION = '0.1.0'
  class TranslationError < RuntimeError; end
end

require File.dirname(__FILE__) + "/dnf_translator/parser"
require File.dirname(__FILE__) + "/dnf_translator/english"

