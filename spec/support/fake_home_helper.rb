module Support
  module FakeHomeHelper
    def use_fake_home_for_all_specs!
      attr_reader :fake_home

      around do |example| 
        @fake_home = Pathname(Dir.mktmpdir)
        original_home, ENV["HOME"] = ENV["HOME"], @fake_home.to_s
        example.run
        ENV["HOME"] = original_home
      end
    end
  end
end
