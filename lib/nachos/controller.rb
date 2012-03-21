require 'octokit'
class Nachos::Controller
  def self.execute(command, options = {})
    new(options).send(command)
  end

  def initialize(options)
    @options = options
  end
  
  def info
    client = Octokit::Client.new
  end

end
