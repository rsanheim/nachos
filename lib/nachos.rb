require 'pathname'
require 'yaml'
require 'octokit'

module Nachos
  VERSION = '0.0.6'
  Version = VERSION
  autoload :Runner, 'nachos/runner'
  autoload :Controller, 'nachos/controller'
  autoload :Github, 'nachos/github'
  autoload :Config, 'nachos/config'
  autoload :User, 'nachos/user'
  class NoConfigurationFound < RuntimeError; end
end
