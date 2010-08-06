require "spec_helper"

describe Nachos::CLI do
  it "works" do
    Nachos::CLI.any_instance.stubs(:github_user).returns("johndoe")
    watched_repos = []
    names = %w[zaphod matt aaron]
    3.to_i.times do |i|
      watched_repos << {
        "url" => "http://github.com/jnunemaker/twitter_#{i}",
        "description" => "API wrapper for Twitter and Twitter Search API's",
        "open_issues" => 7,
        "homepage" => "http://twitter.rubyforge.org/",
        "watchers" => 609,
        "fork" => false,
        "forks" => 120,
        "private" => false,
        "name" => "twitter_#{i}",
        "owner" => names[i],
        "pledgie" => 1193
      }
    end
    body = { "repositories" => watched_repos }.to_json
    url = "http://github.com/api/v2/json/repos/watched/johndoe?"
    FakeWeb.register_uri(:get, url, :body => body)

    Nachos::CLI.start(["watched"])
  end
  
  describe "info" do
    before do
      Thor::Base.shell = FakeShell
    end
      
    it "loads config and displays it, if found" do
      cli = Nachos::CLI.new
      cli.stubs(:github_summary).returns("You have n repos...")
      cli.stubs(:config_path).returns(mock(:exist? => true))
      cli.stubs(:load_config).returns("config here")
      cli.invoke(:info)
      cli.shell.output.should include("Current configuration: config here")
    end
    
    it "tells user there is no config yet" do
      Thor::Base.shell = FakeShell
      cli = Nachos::CLI.new
      cli.stubs(:github_summary).returns("You have n repos...")
      cli.invoke(:info)
      cli.shell.output.should include("No config found - run nachos config to create one")
    end
  end
end
