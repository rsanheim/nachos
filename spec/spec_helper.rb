require 'rspec'
require 'vcr'
require 'nachos'
require 'log_buddy'
require 'support/helpers'
require 'support/fake_home_helper'

RSpec.configure do |c|
  c.mock_with :mocha
  c.filter_run :focused => true
  c.alias_example_to :fit, :focused => true
  c.run_all_when_everything_filtered = true
  c.color_enabled = true
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.extend VCR::RSpec::Macros
  c.include Support::Helpers
end

VCR.configure do |c|
  c.hook_into :faraday
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.default_cassette_options = { :record => :none }
end

