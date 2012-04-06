require 'octokit'
require 'yaml'

class Nachos::Controller
  attr_reader :config

  def self.execute(command, options = {})
    out = new(options).send(command)
    puts out
  rescue Nachos::NoConfigurationFound => e
    abort "You must configure nachos -- run nachos setup to create an example config"
  end

  def self.nachos_config_path
    @nachos_config_path = Pathname("~/.nachos.yml").expand_path
  end

  def initialize(options = {})
    @options = options
    @config = load_config
  end

  # TODO use forwardable for this or delegate
  def nachos_config_path
    self.class.nachos_config_path
  end

  def load_config
    raise Nachos::NoConfigurationFound unless nachos_config_path.exist?
    YAML.load_file(nachos_config_path)
  end

  def info
    out =<<EOL
Nachos version: #{Nachos::Version}
Current user: #{@config[:user]}
You watch #{client.watched.size} repos
EOL
  end

  # client = Octokit::Client.new(:login => "me", :oauth_token => "oauth2token")
  def client
    client = Octokit::Client.new(:login => @config[:username])
  end

end
