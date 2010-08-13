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

end