module Nachos
  module Github
    LGHCONF = "http://github.com/guides/local-github-config"
    GIT_CONFIG = Hash.new do |cache, cmd|
      result = %x{git #{cmd}}.chomp
      cache[cmd] = $?.success? && !result.empty? ? result : nil
    end

    # Either returns the GitHub user as set by git-config(1) or aborts
    # with an error message.
    def github_username(fatal = true)
      if user = GIT_CONFIG[git_config_call("github.user")]
        user
      elsif fatal
        abort("** No GitHub user set. See #{LGHCONF}")
      end
    end

    def github_password
      GIT_CONFIG[git_config_call("github.password")]
    end

    # This is dirty but it lets us override the git config file for testing
    def git_config_call(param)
      ["config", $git_config_override, param].compact.join(" ")
    end
  end
end

