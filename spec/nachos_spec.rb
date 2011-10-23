require 'spec_helper'

describe Nachos do
  describe "execute" do
    it "calls start on CLI" do
      Nachos::CLI.expects(:start)

      nachos = Nachos.new
      nachos.stubs(:exit)
      nachos.execute
    end

    it "exits successfully" do
      Nachos::CLI.stubs(:start)
      nachos = Nachos.new
      nachos.expects(:exit).with(0)
      nachos.execute
    end

    it "can do help" do
      begin
        Nachos::CLI.any_instance.stubs(:shell).returns(shell = stub_everything())
        Nachos.execute("help")
      rescue SystemExit => e
      end
    end
  end

end
