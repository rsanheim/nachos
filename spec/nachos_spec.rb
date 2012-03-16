require 'spec_helper'

describe Nachos do
  def capture_stdout(&block)
    original_stdout = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
    fake.string
  end

  def stub_github_info
    Nachos::Main.any_instance.stubs(:github_user).returns("john-doe")
    Nachos::Main.any_instance.stubs(:github_token).returns("xxx")
    Nachos::Main.any_instance.stubs(:github_summary).returns("zzzz")
  end

  def nachos(*argv)
    capture_stdout do
      Nachos::CLI.start(argv)
    end
  end

  context "with valid github setup" do
    before { stub_github_info }

    it "info returns version info" do
      nachos('info').should include("You are running Nachos #{Nachos::Version}")
    end

    it "watched lists watched repos" do
      repos = [stub(:owner => "defunkt", :name => "github", :description => "github cli")]
      Nachos::Main.any_instance.stubs(:watched).returns(repos)
      nachos('watched').should == "defunkt/github - github cli\n"
    end
  end
end
