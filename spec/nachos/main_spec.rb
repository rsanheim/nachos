require "spec_helper"

describe Nachos::Main do

  describe "repo_root" do
    before { Nachos::Main.any_instance.stubs(:config_exists?).returns(false) }

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
      YAML.stubs(:load_config).returns(nil)
      Nachos::Main.new.config.anything.should == nil
    end
    
    it "wraps loaded yaml in a mashie thing" do
      YAML.stubs(:load_config).returns({:somethign => "foo"})
      main = Nachos::Main.new
      main.config.should be_instance_of(Hashie::Mash)
    end
  end

end