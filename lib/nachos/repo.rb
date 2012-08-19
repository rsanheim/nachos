module Nachos
  class Repo
    attr_reader :repo, :user
    def initialize(repo, user)
      @repo = repo
      @user = user
    end

    def dir
      [repo.owner.login, repo.name].join("-")
    end

    def full_path
      user.repo_root.join(dir)
    end

    # Public: Run a clone or fetch, and return a boolean indicating 
    # the return status of the command
    def sync
      if full_path.exist?
        fetch
      else
        clone
      end
    end

    def clone
      system "git clone #{repo.clone_url} #{full_path}"
    end

    def fetch
      system "git --git-dir=#{repo.full_path.join(".git")} fetch #{repo.clone_url} #{full_path}"
    end
  end

end
