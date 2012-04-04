require 'spec_helper'

describe Nachos::Controller do
  it "works" do
    Nachos::Controller.execute(:info)
  end

  context "config" do
    it "loads config from YAML" do
      path = stub(:exist? => true)
      Nachos::Controller.stubs(:nachos_config_path).returns(path)
      YAML.expects(:load_file).with(path).returns(config = stub("config"))
      controller = Nachos::Controller.new
      controller.config.should == config
    end

    it "uses empty hash if file doesn't exist" do
      YAML.expects(:load_file).returns(config = stub("config"))
      controller = Nachos::Controller.new
      controller.config.should == config
    end
  end

  it "retrieves octokit client for current user" do
    Octokit::Client.expects(:new).with('something')
    Nachos::Controller.new.client
  end

end
