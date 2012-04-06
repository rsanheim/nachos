require 'boson/runner'

module Nachos
  class Runner < Boson::Runner
    def info(options = {})
      puts Controller.execute(:info, options)
    end
  end
end
