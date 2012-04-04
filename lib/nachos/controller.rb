require 'octokit'
class Nachos::Controller

  def self.execute(command, options = {})
    new(options).send(command)
  end

  def self.nachos_config_path
    @nachos_config_path ||= Pathname("~/.nachos.yml").expand_path
  end

  def initialize(options)
    @options = options
    @config = load_config
  end

  # TODO use forwardable for this or delegate
  def nachos_config_path
    self.class.nachos_config_path
  end

  def load_config
    return {} unless nachos_config_path.exist?
    YAML.load_file(nachos_config_path)
  end

  def info
    "You are currently watching #{client.watched.size} repos."
  end

  def client
    client = Octokit::Client.new(@config[:username])
  end

end
