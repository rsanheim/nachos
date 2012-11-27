require 'spec_helper'
require 'tmpdir'

describe "Nachos acceptance" do
  extend Support::FakeHomeHelper
  use_fake_home_for_all_specs!

  # Run a command and capture stdout, stderr, and any errors
  def run(*args)
    stdout, stderr, error = capture { Nachos::Runner.start(args) }
  end

  # Run a command and fail fast on any errors
  def run!(args)
    stdout, stderr, error = run args
    raise error if error
    [stdout, stderr, error]
  end

  context "an unknown subcommand" do
    it "results in an error" do
      stdout, stderr, error = run "some-unknown-command"
      error.should_not be_nil
    end
  end

  context "getting help" do
    it "provides usage for empty commands" do
      stdout, stderr, error = run! nil
      stdout.should match(/Usage: nachos COMMAND/)
    end

    it "provides usage for --help" do
      stdout, stderr, error = run! "--help"
      error.should be_nil
      stdout.should match(/Usage: nachos COMMAND/)
    end
  end

  context "info", :vcr do
    use_vcr_cassette "info", :record => :all

    context "no github configuration exists" do
      it "fails and tells the user to configure things" do
        configure :user => nil
        stdout, stderr, error = run "info"
        error.should be_instance_of(SystemExit)
        stderr.should match "No GitHub user set."
      end
    end

    it "shows basic info" do
      configure :user => "nachos", :password => ENV["NACHOS_PASSWORD"]
      stdout, stderr, error = run! "info"
      stdout.should match /Nachos version: #{Nachos::Version}/
      stdout.should match /Github username: nachos/
      stdout.should match /You belong to 1 organization:/
      stdout.should match /rsanheim-org/
      stdout.should match /You watch 0 repos/
    end
  end

  context "sync", :vcr do
    use_vcr_cassette "info", :record => :new_episodes

    pending "syncs all watched repos locally" do
      configure :user => "johndoe"
      fake_home.join("src").mkdir
      stdout, stderr, error = run! "sync"
      stdout.should match /synced 0 repos/
      #TODO needs net access
      #fake_home.join("src").children.size.should == 2
    end
  end

  context "init" do
    it "writes out an example config file" do
      stdout, stderr, error = capture do
        Nachos::Runner.start ["init"]
      end
      error.should be_nil
      config = Pathname(@fake_home).join(".nachos.yml")
      config.should exist
      config.read.should_not be_empty
    end
  end
end
