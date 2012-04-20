module Support
  module FakeHomeHelper
    def use_fake_home_for_all_specs!
      around do |example| 
        @fake_home = Dir.mktmpdir
        original_home, ENV["HOME"] = ENV["HOME"], @fake_home
        example.run
        ENV["HOME"] = original_home
      end
    end
  end
end
