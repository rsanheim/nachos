require 'spec_helper'
require 'bahia'

RSpec.configure {|c| c.include Bahia }

describe "Nachos acceptance" do

  context "without github config" do
    context "with no commands" do
      it "suceeds and prints help" do
        nachos
        process.should be_success
        stdout.should include("Usage: nachos")
      end

      it "display github message" do
        nachos
        process.should be_success
        puts stdout
        stdout.should include("Your github info is not setup")
      end
    end
  end

end
