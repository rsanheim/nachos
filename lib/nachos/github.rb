class Nachos
  
  class Github
    attr_reader :client
    
    def initialize(github_user, github_token)
      @client = Octopussy::Client.new(:login => github_user, :token => github_token)
    end
    
    def watched
      client.watched.sort_by do |repo|
        [repo["owner"], repo["name"]].join("/")
      end
    end
    
  end
end