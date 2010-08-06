require "spec_helper"

describe Nachos::Main do

  describe "repo_root" do

    it "prefers configured path" do
      main = Nachos::Main.new
      main.config.repo_root = "/here/is/configured/path"
      main.repo_root.should == Pathname("/here/is/configured/path")
    end

    it "uses default path if not otherwise configured" do 
      main = Nachos::Main.new
      main.repo_root.should == Pathname(ENV["HOME"]).join("src")
    end
  end

  describe "config" do
    it "uses 'nil' config if no config found" do
      Nachos::Main.new.config.anything.should == nil
    end
  end

end