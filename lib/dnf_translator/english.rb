module DNFTranslator::English
  include DNFTranslator::Parser

  def self.translate(text)
    begin
      results = DNFExpressionParser.new(text).parse
      ''.tap do |result|
        result << englishify(results.elems_required.first)
        result << englishify_exclusions(results.elems_forbidden.first) unless results.elems_forbidden.empty?
      end
    rescue DNFTranslator::Parser::SyntaxError
      'This is not a valid expression'
    end
  end

private

  def self.englishify_exclusions(excluded_elements)
    " AND no mention of " + englishify(excluded_elements)
  end

  def self.englishify(el)
    case el
      when Element::Literal         then el.value_abs(true)
      when Element::Phrase          then "the phrase " + el.value
      when Element::OrExpression    then el.values.collect{|e| englishify(e)}.join(' OR ' )
      when Element::AndExpression   then el.values.collect{|e| englishify(e)}.join(' AND ')
    end
  end
end