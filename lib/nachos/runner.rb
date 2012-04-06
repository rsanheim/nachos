require 'trollop'
module Nachos
  class Runner
    SUB_COMMANDS = %w(help info sync watched)

    def self.start(args = ARGV)
      global_opts = Trollop::options do
        banner "Nachos is like meta-git"
        #opt :dry_run, "Don't actually do anything", :short => "-n"
        stop_on SUB_COMMANDS
      end

      cmd = args.shift # get the subcommand
      case cmd
      when "info"
        Nachos::Controller.execute "info"
      when "copy"
        Trollop::options do
          opt :double, "Copy twice for safety's sake"
        end
      else
        puts "Usage: nachos COMMAND"
      end
    end
  end
end
