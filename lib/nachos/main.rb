class Nachos
  class Main

    def repo_root
      Pathname(config.repo_root)
    end
    
    def config
      config_path.exist? ? load_config : default_config
    end

    def display_config
      config_path.exist? ? load_config : "No config found - run nachos config to create one"    
    end
    
    def config_path
      Pathname(ENV["HOME"]).join(".nachos")
    end

    def default_config
      @default_config ||= Hashie::Mash.new("repo_root" => "#{ENV["HOME"]}/src")
    end

    def load_config
      YAML.load_file(config_path)
    end
    
  end
end