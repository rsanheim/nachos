class Nachos::Controller
  attr_reader :config, :user

  def self.execute(command, options = {})
    out = new(options).send(command)
    puts out
  rescue Nachos::NoConfigurationFound => e
    abort "You must configure nachos -- run nachos init to create an example config"
  end

  def initialize(options = {})
    @options = options
    @user = Nachos::User.new
  end

  def init
    user.init_config
  end

  def sync
    user.sync
  end

  def info
    out =<<EOL
Nachos version: #{Nachos::Version}
Github username: #{user.github_username}
You watch #{user.watched_repos.size} repos
You belong to #{user.organizations.size} organizations: #{user.organizations.map(&:login).sort}
EOL
  end

  def watched
    out =<<EOL
You are watching the following repos:
#{user.watched}
EOL
  end

  def version
    "Nachos version: #{Nachos::Version}"
  end

end
