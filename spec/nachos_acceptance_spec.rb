require 'spec_helper'
require 'tmpdir'

describe "Nachos acceptance" do
  def configure(options = {})
    File.open("#{@fake_home}/.nachos.yml", "w") do |f|
      f.write(options.to_yaml)
    end
  end

  around do |example| 
    @fake_home = Dir.mktmpdir
    original_home, ENV["HOME"] = ENV["HOME"], @fake_home
    example.run
    ENV["HOME"] = original_home
  end

  context "getting help" do
    it "provides usage" do
      stdout, stderr = capture { Nachos::Runner.start([]) }
      stdout.should match(/Usage: nachos COMMAND/)
    end

    it "tells me about the require github setup"
  end

  context "info", :vcr do
    use_vcr_cassette "info", :record => :new_episodes

    context "no github configuration supplied" do
      it "fails" do
        stdout, stderr, error = capture do
          Nachos::Runner.start ["info"]
        end
        error.should be_instance_of(SystemExit)
        stderr.should match "You must configure nachos"
      end
    end

    it "shows basic info" do
      configure :username => "johndoe"
      stdout, stderr, error = capture do
        Nachos::Runner.start ["info"]
      end
      error.should be_nil
      stdout.should match /Nachos version: #{Nachos::Version}/
      stdout.should match /You watch 2 repos/
    end
  end
end
