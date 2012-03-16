require "octopussy"
require "hub"
require "thor"
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require 'nachos/version'
require 'nachos/config'
require 'nachos/cli'
require 'nachos/github'
require 'nachos/main'

class Nachos

  attr_reader :args

  def Hub(args)
    Hub::Runner.new(*args.split(' '))
  end
end
