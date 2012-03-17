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
        pending "depends on changes to boson to allow overriding help message"
        nachos
        process.should be_success
        stdout.should include("Your github info is not setup")
      end
    end
  end

end
