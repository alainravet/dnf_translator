Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  ## Leave these as is they will be modified for you by the rake gemspec task.
  ## If your rubyforge_project name is different, then edit it and comment out
  ## the sub! line in the Rakefile
  s.name              = 'dnf_translator'
  s.version           = '0.1.0'
  s.date              = '2012-01-16'

  ## Make sure your summary is short. The description may be as long
  ## as you like.
  s.summary     = "Translate Viralheat's requests text into English'"
  s.description = "Translate Viralheat's requests text into English'"

  ## List the primary authors. If there are a bunch of authors, it's probably
  ## better to set the email to an email list or something. If you don't have
  ## a custom homepage, consider using your GitHub URL or the like.
  s.authors  = ["Alain Ravet"]
  s.email    = 'alainravet@gmail.com'
 #s.homepage = 'http://example.com/NAME'

  ## This gets added to the $LOAD_PATH so that 'lib/NAME.rb' can be required as
  ## require 'NAME.rb' or'/lib/NAME/file.rb' can be as require 'NAME/file.rb'
  s.require_paths = %w[lib]

  ## If your gem includes any executables, list them here.
  #s.executables = ["name"]

  ## Specify any RDoc options here. You'll want to add your README and
  ## LICENSE files to the extra_rdoc_files list.
  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.rdoc LICENSE]

  ## List your runtime dependencies here. Runtime dependencies are those
  ## that are needed for an end user to actually USE your code.
  #s.add_dependency('DEPNAME', [">= 1.1.0", "< 2.0.0"])

  ## List your development dependencies here. Development dependencies are
  ## those that are only needed during development
  s.add_development_dependency('test-unit', [">= 1.0"])

  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[
    LICENSE
    README.rdoc
    Rakefile
    dnf_translator.gemspec
    doc/development.txt
    lib/dnf_translator.rb
    lib/dnf_translator/base.rb
    lib/dnf_translator/base/lexer.rb
    lib/dnf_translator/base/value_container.rb
    lib/dnf_translator/base/values_container.rb
    lib/dnf_translator/english.rb
    lib/dnf_translator/parser.rb
    lib/dnf_translator/parser/dnf_expression_parser.rb
    lib/dnf_translator/parser/dnf_lexer.rb
    lib/dnf_translator/parser/element/and_expression.rb
    lib/dnf_translator/parser/element/expression.rb
    lib/dnf_translator/parser/element/literal.rb
    lib/dnf_translator/parser/element/or_expression.rb
    lib/dnf_translator/parser/element/or_operator.rb
    lib/dnf_translator/parser/element/phrase.rb
    lib/dnf_translator/parser/parsing_results.rb
    lib/dnf_translator/parser/pattern.rb
    test/elements/and_expression_test.rb
    test/elements/literal_test.rb
    test/elements/or_expression_test.rb
    test/elements/phrase_test.rb
    test/parsing/dnf_lexer_test.rb
    test/parsing/parser_excludes_test.rb
    test/parsing/parser_includes_test.rb
    test/test_helper.rb
    test/translation/acceptance_test.rb
    test/translation/translation_to_english_test.rb
  ]
  # = MANIFEST =

  ## Test files will be grabbed from the file list. Make sure the path glob
  ## matches what you actually use.
  s.test_files = s.files.select { |path| path =~ /^test\/test_.*\.rb/ }
end