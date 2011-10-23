class Nachos::CLI < Thor

  attr_reader :main
  class_option :dry_run, :type => :boolean, :default => false, :desc => "If specified, the converter will just print the commands and not actually execute them"

  def initialize(*args)
    @main = Nachos::Main.new(self)
    super
  end

  desc "info", "Displays current setup for Nachos"
  def info
    shell.say main.info
  end

  desc "watched", "Display your watched repos on Github"
  def watched
    main.watched.each do |repo|
      shell.say "#{repo.owner}/#{repo.name} - #{repo.description}"
    end
  end

  desc "sync", "Sync repositories"
  def sync
    shell.say main.github_summary
    main.sync
  end

  desc "config", "Create default config (if it doesn't exist)"
  def config
    main.config
  end

  private

  def dry_run?
    options[:dry_run]
  end

end
