module Nachos
  class User
    include Github

    def watched_repos
      client.watched
    end

    # client = Octokit::Client.new(:login => "me", :oauth_token => "oauth2token")
    def client
      client = Octokit::Client.new(:login => github_username)
    end
  end
end
