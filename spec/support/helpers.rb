module Support
  module Helpers
    def configure(options = {})
      git_config_override = Pathname(@fake_home).join(".fake_git_config")
      git_config_override.open("w") do |f|
        f << "[github]\n"
        f << "  user = #{options[:user]}\n" if options[:user]
        f << "  password = #{options[:password]}\n" if options[:password]
      end
      $git_config_override = "-f #{git_config_override}"
    end

    def capture(&block)
      original_stdout = $stdout
      original_stderr = $stderr

      $stdout = fake_stdout = StringIO.new
      $stderr = fake_stderr = StringIO.new
      exception = nil
      begin
        yield
      rescue Exception => e
        exception = e
      ensure
        $stdout = original_stdout
        $stderr = original_stderr
      end
      [fake_stdout.string, fake_stderr.string, exception]
    end
  end
end
