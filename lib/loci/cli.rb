require 'support/trollop'

# I'm thinking Trollop!
opts = Trollop::options do
  version "loci #{Loci::VERSION} (c) 2008 M@ McCray"
  banner <<-EOS
Usage:
       loci#{" <path>" if CLI_MODE == :gen} [options]
where [options] are:
EOS

opt :verbose, "Generate output, loudly", :default => false
opt :force, "Force overwrite of all files", :default => false
opt :dry_run, "Don't write any files", :default => false 

unless CLI_MODE == :gen
  opt :theme, "Ignore config, render with specified theme", :default => false
end

  # opt :file, "Extra data filename to read in, with a very long option description like this one", :type => String
  # opt :volume, "Volume level", :default => 3.0
  # opt :iters, "Number of iterations", :default => 5
end

# Trollop::die :volume, "must be non-negative" if opts[:volume] < 0
# Trollop::die :file, "must exist" unless File.exist?(opts[:file]) if opts[:file]

# module Loci
#   class CLI
#     def self.execute(stdout, arguments=[])
# 
#       # NOTE: the option -p/--path= is given as an example, and should be replaced in your application.
# 
#       options = {
#         :path     => '~'
#       }
#       mandatory_options = %w(  )
# 
#       parser = OptionParser.new do |opts|
#         opts.banner = <<-BANNER.gsub(/^          /,'')
#           This application is wonderful because...
# 
#           Usage: #{File.basename($0)} [options]
# 
#           Options are:
#         BANNER
#         opts.separator ""
#         opts.on("-p", "--path=PATH", String,
#                 "This is a sample message.",
#                 "For multiple lines, add more strings.",
#                 "Default: ~") { |arg| options[:path] = arg }
#         opts.on("-h", "--help",
#                 "Show this help message.") { stdout.puts opts; exit }
#         opts.parse!(arguments)
# 
#         if mandatory_options && mandatory_options.find { |option| options[option.to_sym].nil? }
#           stdout.puts opts; exit
#         end
#       end
# 
#       path = options[:path]
#     end
#   end
# end