require "spec_helper"

describe Nachos::CLI do
  it "works" do
    Nachos::Main.any_instance.stubs(:github_user).returns("johndoe")
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
      @orig_shell, Thor::Base.shell = Thor::Base.shell, FakeShell
    end

    after do
      Thor::Base.shell = @orig_shell
    end
      
    it "displays info from main" do
      Nachos::CLI.any_instance.stubs(:main).returns(mock(:info => "info here"))
      cli = Nachos::CLI.new
      cli.invoke(:info)
      cli.shell.output.should include("info here")
    end
  end
  
  describe "sync" do
    before do
      @orig_shell, Thor::Base.shell = Thor::Base.shell, FakeShell
    end

    after do
      Thor::Base.shell = @orig_shell
    end
    
    it "calls sync on main" do
      main = stub_everything(:github_summary => "")
      main.expects(:sync)
      Nachos::CLI.any_instance.stubs(:main).returns(main)
      cli = Nachos::CLI.new
      cli.invoke(:sync)
    end
    
    it "displays summary sync info" do
      main = stub_everything(:github_summary => "sync summary")
      Nachos::CLI.any_instance.stubs(:main).returns(main)
      cli = Nachos::CLI.new
      cli.invoke(:sync)
      cli.shell.output.should include("sync summary")
    end
  end
end
