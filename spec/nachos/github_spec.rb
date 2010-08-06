require "spec_helper"

describe Nachos::CLI do
  it "sorts watched repos" do
    watched_repos = []
    repos = %w[zaphod/beta zaphod/aardvark matt/foo aaron/baz]
    repos.each do |repo|
      owner, name = repo.split("/")
      watched_repos << {
        "url" => "http://github.com/#{repo}",
        "name" => name,
        "owner" => owner
      }
    end
    body = { "repositories" => watched_repos }.to_json
    url = "http://github.com/api/v2/json/repos/watched/johndoe?"
    FakeWeb.register_uri(:get, url, :body => body)

    github = Nachos::Github.new("johndoe", "token")
    github.watched.map {|r| r["url"] }.should == %w[
      http://github.com/aaron/baz
      http://github.com/matt/foo
      http://github.com/zaphod/aardvark
      http://github.com/zaphod/beta]
  end
end
