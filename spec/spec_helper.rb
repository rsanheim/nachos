$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'nachos'
require 'rspec'
require 'fakeweb'
require 'faker'
require 'json'
require 'log_buddy'
LogBuddy.init

FakeWeb.allow_net_connect = false

RSpec.configure do |config|
  config.mock_with :mocha
  config.formatter = :documentation
  config.color_enabled = true
  config.alias_example_to :fit, :focused => true
  config.filter_run :options => { :focused => true }
  config.run_all_when_everything_filtered = true
end

class FakeShell
  attr_reader :output
  def say(msg, *args)
    (@output ||= "") << msg
  end
end
