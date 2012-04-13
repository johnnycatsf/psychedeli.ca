require 'bundler'
Bundler.require :development

# Extra Rake components
require 'rake/clean'
require 'rake/testtask'

desc "Copy server configuration files from `cfg/` to the public dir."
task :config do
  puts "Copying configuration..."
  system 'cp cfg/.htaccess pub/.htaccess'
  system 'cp cfg/robots.txt pub/robots.txt'
  system 'cp cfg/status_exchange.yml.example cfg/status_exchange.yml' unless File.exists? File.expand_path('./cfg/status_exchange.yml')
end

desc "Compile the static HTML and Markdown content in `app/` with Jekyll"
task :compile do
  puts "Compiling blog content..."
  # refresh and compile the static dir
  system 'rm -rf pub/*'
  system 'bundle exec jekyll --config=cfg/jekyll.yml'
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

# Run the test suite on Travis
task :build => [:compile, :config, :test]

# Build the site, test the code and restart the server
task :default => [:compile, :test, :restart]
