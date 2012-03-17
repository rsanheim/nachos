require 'spec_helper'
require 'bahia'

#Bahia.project_directory = File.expand_path(File.join(File.dirname(__FILE__), *%w[..]))
#Bahia.command_method = 'nachos'
#Bahia.command = 'nachos'
#Rspec.configure {|c| c.include Bahia }

describe "Nachos acceptance", :pending => true do

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
