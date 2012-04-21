require 'spec_helper'

describe Nachos::Config do
  it "delegates config path to class" do
    Nachos::Config.new.config_path.should == Nachos::Config.config_path
  end

  context "config" do
    it "uses defaults if there is no config file" do
      pending
      Nachos::Config.new.config.should == Nachos::Config.new.default_config
    end
  end
end

