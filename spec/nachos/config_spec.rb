require "spec_helper"

describe Nachos::Config do

  describe "repo_root" do
    before { Nachos::Config.any_instance.stubs(:config_exists?).returns(false) }

    it "prefers configured path" do
      config = Nachos::Config.new
      config.config.repo_root = "/here/is/configured/path"
      config.repo_root.should == Pathname("/here/is/configured/path")
    end

    it "uses default path if not otherwise configured" do 
      config = Nachos::Config.new
      config.repo_root.should == Pathname(ENV["HOME"]).join("src")
    end
  end

  describe "config" do
    it "uses 'nil' config if no config found" do
      YAML.stubs(:load_config).returns(nil)
      Nachos::Config.new.config.anything.should == nil
    end
    
    it "wraps loaded yaml in a mashie thing" do
      YAML.stubs(:load_config).returns({:somethign => "foo"})
      config = Nachos::Config.new
      config.config.should be_instance_of(Hashie::Mash)
    end
  end
  
end