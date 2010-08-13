class Nachos
  class Main
    extend Forwardable
    include Nachos::Github
    def_delegators :cli, :shell, :dry_run?
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
      chdir config.config.repo_root do
        watched.each do |repo|
          git_url = repo.url.gsub("http", "git")
          run Hub("clone #{git_url} #{repo.owner}-#{repo.name}").command
        end
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
    
  end
end