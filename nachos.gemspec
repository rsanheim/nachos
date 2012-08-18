Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  ## Leave these as is they will be modified for you by the rake gemspec task.
  ## If your rubyforge_project name is different, then edit it and comment out
  ## the sub! line in the Rakefile
  s.name              = 'nachos'
  s.version           = '0.0.6'
  s.date              = '2012-03-21'
  s.rubyforge_project = 'nachos'

  s.summary     = "Nachos syncs your github world to your local machine"
  s.description = s.summary

  s.authors  = ["Rob Sanheim"]
  s.email    = 'rsaheim@gmail.com'
  s.homepage = 'http://github.com/rsanheim/nachos'
  s.require_paths = %w[lib]
  s.executables = ["nachos"]
  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md LICENSE]

  s.add_dependency 'trollop', '1.16.2'
  s.add_dependency 'octokit', '1.10.0'

  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'log_buddy'
  s.add_development_dependency 'rspec', '~> 2.9'
  s.add_development_dependency 'rake', '~> 0.9.2'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'growl'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'

  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[
    Gemfile
    Gemfile.lock
    README.md
    Rakefile
    lib/nachos.rb
    nachos.gemspec
  ]
  # = MANIFEST =

  ## Test files will be grabbed from the file list. Make sure the path glob
  ## matches what you actually use.
  s.test_files = s.files.select { |path| path =~ /^spec\/.*_spec\.rb/ }
end
