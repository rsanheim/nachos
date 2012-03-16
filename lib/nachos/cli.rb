require 'boson'
require 'boson/runner'

class Nachos::CLI < Boson::Runner

  attr_reader :main

  def initialize(*args)
    @main = Nachos::Main.new(self)
    @options = {}
    super
  end

  def self.dry_run
    option :dry_run, :type => :boolean, :desc => "If specified, the converter will just print the commands and not actually execute them"
  end

  desc "Displays current setup for Nachos"
  def info
    say main.info
  end

  dry_run
  desc "Display your watched repos on Github"
  def watched(options={})
    @options = options
    main.watched.each do |repo|
      say "#{repo.owner}/#{repo.name} - #{repo.description}"
    end
  end

  dry_run
  desc "Sync repositories"
  def sync(options={})
    @options = options
    say main.github_summary
    main.sync
  end

  dry_run
  desc "Create default config (if it doesn't exist)"
  def config(options={})
    @options = options
    main.config
  end

  private
  def say(msg)
    puts msg
  end

  def dry_run?
    @options[:dry_run]
  end

end
