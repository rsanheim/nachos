require 'bundler/setup'
Bundler.require(:development)

require "json"  # not sure why this needs to be here....but it does.
require "nachos"

LogBuddy.init

FakeWeb.allow_net_connect = false

RSpec.configure do |config|
  config.mock_with :mocha
  config.formatter = :documentation
  config.color_enabled = true
  config.alias_example_to :fit, :focused => true
  config.filter_run :focused => true
  config.run_all_when_everything_filtered = true
end

class FakeShell
  attr_reader :output
  def say(msg, *args)
    (@output ||= "") << msg
  end
end
