require 'rake/testtask'

desc "Compiles the application with Jekyll"
task :compile do
  puts "Compiling blog content..."
  # refresh and compile the static dir
  system 'rm -rf pub/*'
  system 'bundle exec jekyll --config=cfg/jekyll.yml'
  # special configuration that gets loaded at the root of the static dir
  system 'cp cfg/.htaccess pub/.htaccess'
  system 'cp cfg/robots.txt pub/robots.txt'
end
# Defaults to `compile`
task :default => :compile


desc "Restarts the Rack stack"
task :restart do
  puts "Restarting the server..."
  system 'touch tmp/restart.txt'
  puts "done"
end



desc "Runs all of the tests for psychedeli.ca"
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end
