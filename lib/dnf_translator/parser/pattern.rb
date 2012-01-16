module DNFTranslator::Parser
  module Pattern
    START_PARENS_PATTERN                = /\s*\(\s*/
    MINUS_START_PARENS_PATTERN          = /\s*-\(\s*/
    END_PARENS_PATTERN                  = /\s*\)\s*/
    EMPTY_PARENS_PATTERN                = /\s*\(\s*\)\s*/

    OR_EXPRESSION_SEPARATOR_PATTERN     = /\s*\|\s*/

    QUOTED_MULTIWORDS_PHRASE_PATTERN    = /^('[^']+\s+[^']+'|"[^"]+\s+[^"]+")/
    QUOTED_SINGLEWORD_LITERAL_PATTERN   = /^('[^'\s]+'|"[^"\s]+")/
    UNQUOTED_LITERAL_PATTERN            = /^["']?[-]?[#]?(\w|\.)+["']?/
  end
end
