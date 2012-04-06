require 'spec_helper'
require 'tmpdir'

describe "Nachos acceptance" do
  context "getting help" do
    fit "provides usage" do
      stdout, stderr = capture { Nachos::Runner.start([]) }
      stdout.should match(/Usage: nachos \[OPTIONS\]/)
    end

    it "tells me about the require github setup"
  end

  context "info", :vcr do
    use_vcr_cassette "info", :record => :new_episodes

    context "no github configuration supplied" do
      it "fails" do
        Nachos::Runner.start
        #nachos "info"
        process.should_not be_success
        stderr.should match "You must configure nachos"
      end
    end

    def configure(options = {})
      dir = Dir.mktmpdir
      ENV["HOME"] = dir

      File.open("#{dir}/.nachos.yml", "w") do |f|
        f.write( { :username => "johndoe" }.to_yaml )
      end
    end

    it "succeeds" do
      configure :username => "johndoe"
      nachos "info"
      puts stderr
      puts stdout
      process.should be_success
      stdout.should match /Nachos #{Nachos::Version} as johndoe/
    end

    it "tells me my github username and watched repos" do
      nachos "info"
      pending "fake out github stuff, etc"
      process.should be_success
      stdout.should == <<EOL
You are using nachos as 'johndoe'.
You have 22 watched repos, and 10 private repos that are being synced
EOL
    end
  end
end
