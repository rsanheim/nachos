module Nachos
  VERSION = '0.0.6'
  Version = VERSION
  autoload :Runner, 'nachos/runner'
  autoload :Controller, 'nachos/controller'
  class NoConfigurationFound < RuntimeError; end
end
