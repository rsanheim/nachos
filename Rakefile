require 'rubygems'
require 'rake'
require File.join(File.dirname(__FILE__), *%w[lib nachos version])

Bundler::GemHelper.install_tasks

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

task :spec

task :default => [:coverage]

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "nachos #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
