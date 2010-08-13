class Nachos::CLI < Thor

  attr_reader :config, :main
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
    shell.say main.sync_summary
    main.sync
  end

  private
  
  def Hub(args)
    Hub::Runner.new(*args.split(' '))
  end
  
  def dry_run?
    options[:dry_run]
  end
  
  def run(cmd)
    if dry_run?
      say cmd
    else
      system cmd
    end
  end
  
  def github_summary
    "You have #{github.watched.size} watched repos, and #{github.client.list_repos.size} owned repos."
  end
  
end