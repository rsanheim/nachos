require 'bahia'

describe "Nachos acceptance" do
  include Bahia

  context "getting help" do
    it "provides usage" do
      nachos
      stdout.should =~ /Usage: nachos \[OPTIONS\]/
    end
    it "tells me about the require github setup"
  end

  context "info" do
    it "succeeds" do
      nachos "info"
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
