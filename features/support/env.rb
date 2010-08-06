$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'log_buddy'
require 'nachos'
require 'aruba'
require 'mocha'
require 'json'
require 'rspec/core'

Before do
  bin_path = File.join(File.dirname(__FILE__), *%w[.. .. bin])
  ENV["PATH"] = "#{ENV["PATH"]}:#{bin_path}"
  system('which nachos > /dev/null') || abort('nachos not on the path - binary features will not work')
end

module ArubaOverrides
  def detect_ruby_script(cmd)
    if cmd =~ /^nachos/
      "ruby -I../../lib -I./fakeweb -S ../../bin/#{cmd}"
    else
      super(cmd)
    end
  end
end

module Helper
  extend self
  attr_accessor :watched_repos
  def current_user=(user)
    @current_user = user
  end
  def current_user
    @current_user || raise("No current user set")
  end
end

World(Mocha::API)
World(ArubaOverrides)
World(Helper)
