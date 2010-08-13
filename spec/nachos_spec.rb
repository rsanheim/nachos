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
  end
end
