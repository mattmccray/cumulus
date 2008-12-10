require File.join(File.dirname(__FILE__), "../test_helper.rb")
CLI_MODE = :test
require 'cumulus/cli'

class CumulusCliTest < Test::Unit::TestCase
  
  context "Cumulus::CLI" do
    
    setup do
      #     @stdout_io = StringIO.new
      #     Cumulus::CLI.execute(@stdout_io, [])
      #     @stdout_io.rewind
      #     @stdout = @stdout_io.read
    end
    
    should "..." do
      
    end
    
  end

end