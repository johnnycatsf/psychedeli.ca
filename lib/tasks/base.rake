# Base tasks have no namespace, and are usually system on the local development
# machine to restart the server, recompile static content, or install the
# server to Pow.

require 'rake/testtask'

desc "Copy server configuration files from `cfg/` to the public dir."
task :config do
  system 'cp cfg/.htaccess pub/.htaccess'
  system 'cp cfg/robots.txt pub/robots.txt'
end

desc "Compile the static HTML and Markdown content in `app/` with Jekyll"
task :compile do
  puts "Compiling blog content..."
  # refresh and compile the static dir
  system 'rm -rf pub/*'
  system 'bundle exec jekyll --config=cfg/jekyll.yml'
  Rake::Task['config'].invoke
  Rake::Task['restart'].invoke
end

desc "Restart the Ruby web server"
task :restart do
  puts "Restarting the server..."
  system 'touch tmp/restart.txt'
  puts "done"
end

desc "Run the test suite"
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

# Defaults to `compile`
task :default => :compile
