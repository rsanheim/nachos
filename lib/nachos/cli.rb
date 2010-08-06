class Nachos::CLI < Thor

  attr_reader :main
  class_option :dry_run, :type => :boolean, :default => false, :desc => "If specified, the converter will just print the commands and not actually execute them"
  
  def initialize(*args)
    @main = Nachos::Main.new
    super
  end
  
  LGHCONF = "http://github.com/guides/local-github-config"
  GIT_CONFIG = Hash.new do |cache, cmd|
    result = %x{git #{cmd}}.chomp
    cache[cmd] = $?.success? && !result.empty? ? result : nil
  end
  
  desc "info", "Displays current setup for Nachos"
  def info
    shell.say <<-EOL
You are running Nachos #{Nachos::VERSION} as #{github_user}.
#{github_summary}
Current configuration: #{main.display_config}
EOL
  end
  
  desc "watched", "Display your watched repos on Github"
  def watched
    github.watched.each do |repo|
      shell.say "#{repo.owner}/#{repo.name} - #{repo.description}"
    end
  end
  
  desc "sync", "Sync repositories"
  def sync
    repos = github.watched
    shell.say "About to sync #{repos.size} repositories"
    Dir.chdir(main.config.repo_root) do
      repos.each do |repo|
        run Hub("clone #{repo.url} #{repo.owner}-#{repo.name}").command
      end
    end
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
      shell.say cmd
    else
      system cmd
    end
  end
  
  def github_summary
    "You have #{github.watched.size} watched repos, and #{github.client.list_repos.size} owned repos."
  end
  
  def github
    @github ||= Nachos::Github.new(github_user, github_token)
  end

  # Either returns the GitHub user as set by git-config(1) or aborts
  # with an error message.
  def github_user(fatal = true)
    if user = GIT_CONFIG['config github.user']
      user
    elsif fatal
      abort("** No GitHub user set. See #{LGHCONF}")
    end
  end

  def github_token(fatal = true)
    if token = GIT_CONFIG['config github.token']
      token
    elsif fatal
      abort("** No GitHub token set. See #{LGHCONF}")
    end
  end
  
end