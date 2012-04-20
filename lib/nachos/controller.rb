require 'octokit'
require 'yaml'

class Nachos::Controller
  attr_reader :config, :user

  def self.execute(command, options = {})
    out = new(options).send(command)
    puts out
  rescue Nachos::NoConfigurationFound => e
    abort "You must configure nachos -- run nachos init to create an example config"
  end

  def self.nachos_config_path
    @nachos_config_path = Pathname("~/.nachos.yml").expand_path
  end

  def initialize(options = {})
    @options = options
    @user = Nachos::User.new
  end

  def config
    @config ||= load_config
  end

  # TODO use forwardable for this or delegate
  def nachos_config_path
    self.class.nachos_config_path
  end

  def load_config
    raise Nachos::NoConfigurationFound unless nachos_config_path.exist?
    YAML.load_file(nachos_config_path)
  end

  def init
    return "You already have a config file" if nachos_config_path.exist?
    nachos_config_path.open("w") { example_config }
    <<EOL
Example config generated at #{nachos_config_path}:
#{nachos_config_path.read}
EOL
  end

  def example_config
    { "username" => ENV["USER"] }.to_yaml
  end

  def info
    out =<<EOL
Nachos version: #{Nachos::Version}
Github username: #{user.github_username}
You watch #{client.watched.size} repos
EOL
  end

  # client = Octokit::Client.new(:login => "me", :oauth_token => "oauth2token")
  def client
    client = Octokit::Client.new(:login => config[:username])
  end

end
