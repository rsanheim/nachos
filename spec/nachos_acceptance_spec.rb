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
    error.should be_nil
    [stdout, stderr, error]
  end

  context "an unknown subcommand" do
    it "results in an error" do
      stdout, stderr, error = run "some-unknown-command"
      error.should_not be_nil
    end

  end

  context "getting help" do
    it "provides usage" do
      stdout, stderr, error = run! nil
      stdout.should match(/Usage: nachos COMMAND/)
    end

    it "provides usage for --help" do
      stdout, stderr, error = run! "--help"
      error.should be_nil
      stdout.should match(/Usage: nachos COMMAND/)
    end

    it "tells me about the required github setup"
  end

  context "info", :vcr do
    use_vcr_cassette "info", :record => :new_episodes

    context "no github configuration supplied" do
      it "fails and tells the user to configure things" do
        stdout, stderr, error = capture do
          Nachos::Runner.start ["info"]
        end
        error.should be_instance_of(SystemExit)
        stderr.should match "You must configure nachos"
      end
    end

    it "shows basic info" do
      configure :username => "johndoe"
      stdout, stderr, error = capture do
        Nachos::Runner.start ["info"]
      end
      error.should be_nil
      stdout.should match /Nachos version: #{Nachos::Version}/
      stdout.should match /You watch 2 repos/
    end
  end

  context "init" do
    it "writes out an example config file" do
      stdout, stderr, error = capture do
        Nachos::Runner.start ["init"]
      end
      error.should be_nil
      Pathname(@fake_home).join(".nachos.yml").exist?.should be_true
    end
  end
end
