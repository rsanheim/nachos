require 'spec_helper'

describe Nachos::Controller do
  context "config" do
    it "loads config from YAML" do
      path = stub(:exist? => true)
      Nachos::Controller.stubs(:nachos_config_path).returns(path)
      YAML.expects(:load_file).with(path).returns(config = stub("config"))
      controller = Nachos::Controller.new
      controller.config.should == config
    end
  end
end
