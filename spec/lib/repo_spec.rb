require 'spec_helper'

describe Nachos::Repo do

  def user
    Nachos::User.new
  end

  it "has a dir" do
    octokit_repo = stub(:name => "nachos", :owner => stub(:login => "rsanheim"))
    repo = Nachos::Repo.new(octokit_repo, user)
    repo.dir.should == "rsanheim-nachos"
  end

  it "has a full path" do
    octokit_repo = stub(:name => "nachos", :owner => stub(:login => "rsanheim"))
    repo = Nachos::Repo.new(octokit_repo, user)
    repo.full_path.should == user.repo_root.join("rsanheim-nachos")
  end
end
