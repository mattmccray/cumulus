%w[rubygems rake rake/clean rake/testtask fileutils newgem rubigen shoulda/tasks].each { |f| require f }
require File.dirname(__FILE__) + '/lib/cumulus'


# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.new('cumulus', Cumulus::VERSION) do |p|
  p.developer('M@ McCray', 'darthapo@gmail.com')
  p.changes              = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.post_install_message = 'PostInstall.txt'
  p.rubyforge_name       = p.name
  p.extra_deps         = [
    ['hpricot','>= 0.6'],
    ['liquid', '>= 1.9'],
    ['rake',   '>= 0.8']
  ]
  p.extra_dev_deps = [
    ['newgem', ">= #{::Newgem::VERSION}"],
    ['shoulda', ">= 2.0"],
    ['activesupport']
  ]
  p.test_globs = "test/**/*_test.rb"
  p.clean_globs |= %w[**/.DS_Store tmp *.log]
  path = (p.rubyforge_name == p.name) ? p.rubyforge_name : "\#{p.rubyforge_name}/\#{p.name}"
  p.remote_rdoc_dir = File.join(path.gsub(/^#{p.rubyforge_name}\/?/,''), 'rdoc')
  p.rsync_args = '-av --delete --ignore-errors'
end

require 'newgem/tasks' # load /tasks/*.rake
Dir['tasks/**/*.rake'].each { |t| load t }

desc "Test shoulda specs"
Rake::TestTask.new('shoulda:specs') do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

#task :default => ['shoulda:specs']
