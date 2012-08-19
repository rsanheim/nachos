module Nachos
  class User
    include Github
    attr_reader :config

    def watched_repos
      client.watched
    end

    def repo_root
      Pathname(ENV["HOME"]).join("src")
    end

    def config
      @config ||= Config.new
    end

    def init_config
      config.init
    end

    def sync
      count = 0
      client.watched.each do |octokit_repo|
        repo = Nachos::Repo.new(octokit_repo)
        success = repo.sync
        count += 1 if success
      end
      "Successfully synced #{count} repos"
    end

    def organizations
      client.organizations
    end

    def organization_repos
      repos = organizations.inject([]) do |sum, org|
        sum << client.org_repos(org.login)
      end
    end

    # client = Octokit::Client.new(:login => "me", :oauth_token => "oauth2token")
    # client = Octokit::Client.new(:login => "me", :password => "sekret")
    def client
      auth = { :login => github_username }
      auth[:password] = github_password if github_password
      client = Octokit::Client.new(auth)
    end
  end
end
