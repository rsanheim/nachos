require 'boson/runner'

module Nachos
  class Runner < Boson::Runner
    def info(options = {})
      Controller.execute(:info, options)
    end

    def something
    end
  end
end
