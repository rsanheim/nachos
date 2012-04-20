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
      when nil, "--help"
        puts "Usage: nachos COMMAND"
      when "info", "init"
        Nachos::Controller.execute cmd
      when "copy"
        Trollop::options do
          opt :double, "Copy twice for safety's sake"
        end
      else
        abort "nachos: #{cmd} is not a nachos command.  See nachos --help"
      end
    end
  end
end
