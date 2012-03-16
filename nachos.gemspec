# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nachos/version"

Gem::Specification.new do |s|
  s.name        = "nachos"
  s.version     = Nachos::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rob Sanheim"]
  s.email       = ["rsanheim@gmail.com"]
  s.homepage    = "http://github.com/rsanheim/nachos"
  s.summary     = %q{Sync yo gems}
  s.description = %q{Sync your gems}

  s.rubyforge_project = "nachos"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", "~> 2.4"
  s.add_development_dependency "bahia"
  s.add_development_dependency "faker"
  s.add_development_dependency "mocha"
  s.add_development_dependency "fakeweb"
  s.add_development_dependency "log_buddy"
  s.add_development_dependency "rake"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "rb-fsevent" if RUBY_PLATFORM =~ /darwin/

  s.add_runtime_dependency "octopussy"
  s.add_runtime_dependency "boson"
  s.add_runtime_dependency "git-hub", "1.4.1"
  # s.add_runtime_dependency %q<json>, [">= 0"])
end
