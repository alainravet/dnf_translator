module DNFTranslator
  module Base
  end
end

Dir[File.join(File.dirname(__FILE__),'base', "**","*.rb")].each {|f| require f}
