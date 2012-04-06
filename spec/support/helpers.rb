module Support
  module Helpers
    def configure(options = {})
      File.open("#{@fake_home}/.nachos.yml", "w") do |f|
        f.write(options.to_yaml)
      end
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
