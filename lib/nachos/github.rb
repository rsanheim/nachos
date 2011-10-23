class Nachos

  module Github
    LGHCONF = "http://github.com/guides/local-github-config"
    GIT_CONFIG = Hash.new do |cache, cmd|
      result = %x{git #{cmd}}.chomp
      cache[cmd] = $?.success? && !result.empty? ? result : nil
    end

    attr_reader :client

    def watched
      client.watched.sort_by do |repo|
        [repo["owner"], repo["name"]].join("/")
      end
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

    def github_summary
      "You have #{watched.size} watched repos, and #{client.list_repos.size} owned repos."
    end

    def client
      @client ||= Octopussy::Client.new(:login => github_user, :token => github_token)
    end

  end
end
