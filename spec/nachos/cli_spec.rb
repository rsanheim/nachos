require "spec_helper"

describe Nachos::CLI do
  it "works" do
    Nachos::Main.any_instance.stubs(:github_user).returns("johndoe")
    Nachos::Main.any_instance.stubs(:github_token).returns("xxxx")

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

end

