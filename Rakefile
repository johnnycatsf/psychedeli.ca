require 'bundler'
Bundler.require :framework, :development

# Extra Rake components
require 'rake/clean'
require 'rake/testtask'
# require 'rake/sprocketstask'

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
  Rake::Task['restart'].invoke
end

desc "Server tasks"
namespace :server do
  desc "Restart the app server"
  task :restart do
    puts "Restarting the server..."
    system 'touch tmp/restart.txt'
    puts "done"
  end
end


desc "Run the test suite"
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

# desc "Asset pipeline"
# Rake::SprocketsTask.new do |t|
#   t.output = './pub/css'
#   t.environment = Assets.stylesheets
# end

desc "Run the test suite on CI"
task :build => [:compile, :config, :test]

# desc "Build the site, test the code and restart the server"
task :default => [:compile, :test, :restart]
