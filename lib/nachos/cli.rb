class Nachos::CLI < Thor

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
Current configuration: #{config_msg}
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
    repos.each do |repo|
      system Hub("clone #{repo.url}").command
    end
  end

  def config
    config_path.exist? ? load_config : default_config
  end
  
  private
  
  def config_msg
    config_path.exist? ? load_config : "No config found - run nachos config to create one"    
  end
  
  def github_summary
    "You have #{github.watched.size} watched repos, and #{github.client.list_repos.size} owned repos."
  end
  
  def default_config
    @default_config ||= Hashie::Mash.new("repo_root" => "#{ENV["HOME"]}/src")
  end

  def config_path
    Pathname(ENV["HOME"]).join(".nachos")
  end

  def load_config
    YAML.load_file(config_path)
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
  
  def repo_root
    Pathname(config.repo_root)
  end
end