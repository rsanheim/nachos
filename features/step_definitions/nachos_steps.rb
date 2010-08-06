Given /^I am locally configured for Github as "([^\"]*)"$/ do |username|
  Helper.current_user = username
  Nachos.any_instance.stubs(:github_user).returns(username)
  Nachos.any_instance.stubs(:github_token).returns("some-valid-token")
end

When /^I execute nachos "([^"]*)"$/ do |args|
  require 'stringio'
  begin # emulating how Aruba works, so we can use the same matchers
    Nachos.stdout, @original_stdout = StringIO.new, Nachos.stdout
    nachos = Nachos.execute(args)
    output = nachos.out
    output.rewind
    @last_stdout = output.read
    # @last_stderr...
    @last_exit_status = nachos.exit_code
  rescue => e
    p e; e.message
    puts e.backtrace[0..10].join("\n")
  ensure
    Nachos.stdout = @original_stdout
  end
end

Given /^I have "([^\"]*)" watched repositories on Github$/ do |num_repos|
  Helper.watched_repos = []
  num_repos.to_i.times do |i|
    Helper.watched_repos << {
      "url" => "http://github.com/jnunemaker/twitter_#{i}",
      "description" => "API wrapper for Twitter and Twitter Search API's",
      "open_issues" => 7,
      "homepage" => "http://twitter.rubyforge.org/",
      "watchers" => 609,
      "fork" => false,
      "forks" => 120,
      "private" => false,
      "name" => "twitter_#{i}",
      "owner" => "jnunemaker",
      "pledgie" => 1193
    }
  end
  body = { "repositories" => Helper.watched_repos }.to_json
  url = "http://github.com/api/v2/json/repos/watched/#{Helper.current_user}?"
  FakeWeb.register_uri(:get, url, :body => body)
end

Given /^I expect nachos to clone all watched repositories$/ do
  Nachos.any_instance.stubs(:system).with(includes("git clone"))
end
