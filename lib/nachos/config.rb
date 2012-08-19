module Nachos
  class Config
    def self.config_path
      @config_path = Pathname("~/.nachos.yml").expand_path
    end

    extend Forwardable
    def_delegator('self.class', :config_path)

    def default_config
      {
        :oss_repo_root => "~/src/oss",
        :private_repo_root => "~/src/private"
      }
    end

    def config
      @config ||= load_config
    end
    alias :load :config

    def load_config
      return unless config_path.exist?
      YAML.load_file(config_path)
    end

    def init
      return "You already have a config file" if config_path.exist?
      config_path.open("w") { |f| f << default_config.to_yaml }
<<EOL
Example config generated at #{config_path}:
#{config_path.read}
EOL
    end

  end
end
