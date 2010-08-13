require "spec_helper"

describe Nachos::Main do

  describe "info" do
    it "shows summary of what is up" do
      main = Nachos::Main.new(Nachos::CLI.new)
      main.stubs(:github_user => "jdoe")
      main.stubs(:github_summary => "github summary")
      main.info.should include("jdoe")
      main.info.should include(Nachos::VERSION)
      main.info.should include("github summary")
    end
  end
  
  describe "sync" do
    it "syncs all repos" do
      main = Nachos::Main.new(Nachos::CLI.new)
      main.stubs(:watched).returns([])
      main.sync
    end
  end

  describe "repo_exists?" do
    it "returns true if dir exists" do
      Pathname.any_instance.expects(:directory?).returns(true)
      repo = Hashie::Mash.new(:owner => "jdoe", :name => "project")
      main = Nachos::Main.new(Nachos::CLI.new)
      main.repo_exists?(repo).should be_true
    end
    
    it "returns false if dir does not exist" do
      Pathname.any_instance.expects(:directory?).returns(false)
      repo = Hashie::Mash.new(:owner => "jdoe", :name => "project")
      main = Nachos::Main.new(Nachos::CLI.new)
      main.repo_exists?(repo).should be_false
    end
  end
end