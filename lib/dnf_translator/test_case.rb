require 'test/unit'
load File.expand_path File.join(File.dirname(__FILE__),'..',"dnf_translator.rb")

module DNFTranslator
  class TestCase < Test::Unit::TestCase

    def test_to_avoid_a__No_tests_were_specified__error
    end

    def check_lexed_literals_or_phrases_are(expected, params)
      lexer = DNFTranslator::Parser::DNFLexer.new(params[:source])
      actual = [] ;
      expected.length.times do
        el = lexer.read_next_token_if_a_literal_or_phrase;
        actual << (el && el.to_s)
      end
      assert_equal expected, actual
    end

    def check_parsing(source_string, expected_required_values, expected_forbidden_values = [])
      stack = DNFTranslator::Parser::DNFExpressionParser.new(source_string).parse
      unless stack == DNFTranslator::Parser::ParsingResults.new(expected_required_values, expected_forbidden_values )
        assert_equal expected_required_values , stack.elems_required,  "REQUIRED VALUES ERROR"
        assert_equal expected_forbidden_values, stack.elems_forbidden, "EXCLUDED VALUES ERROR"
      end
    end

    def assert_translation_is(expected_translation, params)
      assert_equal expected_translation,
                   DNFTranslator::English.translate(params[:source])
    end

    def assert_syntax_error_in(source_string)
      assert_raise DNFTranslator::Parser::SyntaxError do
        DNFTranslator::Parser::DNFExpressionParser.new(source_string).parse
      end
    end

    def and_expr(*elements)
      elements = elements.collect{|el| literal(el) }
      DNFTranslator::Parser::Element::AndExpression.new *Array(elements)
    end

    def or_expr(*elements)
      elements = elements.collect{|el| literal(el) }
      DNFTranslator::Parser::Element::OrExpression.new *Array(elements)
    end

    def literal(el)
      el.is_a?(String) ?
          DNFTranslator::Parser::Element::Literal.new(el) :
          el
    end

  end
end
