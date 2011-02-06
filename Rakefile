require 'rubygems'
require 'rake'
require File.join(File.dirname(__FILE__), *%w[lib nachos version])
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.version = Nachos::VERSION
    gem.name = "nachos"
    gem.summary = %Q{Nachos - sync and stuff with Github}
    gem.description = %Q{Because everyone loves Nachos!}
    gem.email = "rsanheim@gmail.com"
    gem.homepage = "http://github.com/rsanheim/nachos"
    gem.authors = ["Rob Sanheim"]
    gem.add_dependency "octopussy"
    gem.add_dependency "thor"
     # may want to vendor this...could conflict with the manual install folks
    gem.add_dependency "git-hub", "1.4.1"
    gem.add_development_dependency "rspec", "~> 2.4"
    gem.add_development_dependency "faker"
    gem.add_development_dependency "mocha"
    gem.add_development_dependency "fakeweb"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

if RUBY_VERSION <= "1.8.7"
  RSpec::Core::RakeTask.new(:coverage) do |spec|
    spec.pattern = 'spec/**/*_spec.rb'
    spec.rcov_opts = %[-Ilib -Ispec --exclude "gems/*,/Library/Ruby/*,config/*" --text-summary  --sort coverage]
    spec.rcov = true
  end
else
  task :coverage => :spec
end

task :spec => :check_dependencies

task :default => [:check_dependencies, :coverage]

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "nachos #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
