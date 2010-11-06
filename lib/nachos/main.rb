class Nachos
  class Main
    extend Forwardable
    include Nachos::Github
    def_delegators :cli, :shell, :dry_run?
    def_delegators :config, :config
    attr_reader :cli, :config
    
    def initialize(cli)
      @cli = cli
      @config = Nachos::Config.new
    end
    
    def info
%[You are running Nachos #{Nachos::VERSION} as #{github_user}.
#{github_summary}
Current configuration: #{config.display_config}]
    end
    
    def sync
      chdir config.repo_root do
        watched.each { |repo| sync_repo(repo) }
      end
    end
    
    def chdir(dir)
      shell.say_status :inside, dir
      if dry_run?
        yield
      else
        FileUtils.mkdir_p(dir) unless File.exist?(dir)
        FileUtils.cd(dir) { yield }
      end
    end
    
    def sync_repo(repo)
      git_url = repo.url.gsub("http", "git")
      path = repo_path(repo)
      if repo_exists?(repo)
        chdir(path) do
          run Hub("fetch").command
        end
      else
        run Hub("clone #{git_url} #{repo.owner}-#{repo.name}").command
      end
    end
    
    def repo_path(repo)
      Pathname(config.repo_root.join("#{repo.owner}-#{repo.name}"))
    end
    
    def repo_exists?(repo)
      repo_path(repo).directory?
    end
    
    def Hub(args)
      Hub::Runner.new(*args.split(' '))
    end
    
    def run(cmd)
      if dry_run?
        shell.say cmd
      else
        system cmd
      end
    end

  end
end