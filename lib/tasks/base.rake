# Base tasks have no namespace, and are usually system on the local development
# machine to restart the server, recompile static content, or install the
# server to Pow.

require 'rake/testtask'

desc "Installs the application onto your local Pow server for development"
task :install do
  puts "Installing to Pow..."
  system "ln -s ~/.pow/blog #{File.expand_path(__FILE__)}"
end

desc "Moves the proper configuration into the public directory to get picked \
      up by the server."
task :configure do
  system 'cp cfg/.htaccess pub/.htaccess'
  system 'cp cfg/robots.txt pub/robots.txt'
end

desc "Compiles the application with Jekyll"
task :compile do
  puts "Compiling blog content..."
  # refresh and compile the static dir
  system 'rm -rf pub/*'
  system 'bundle exec jekyll --config=cfg/jekyll.yml'
  Rake::Task['configure'].invoke
  Rake::Task['restart'].invoke
end

desc "Restarts the Ruby web server"
task :restart do
  puts "Restarting the server..."
  system 'touch tmp/restart.txt'
  puts "done"
end

desc "Pushes the latest code to the staging server"
task :stage do
  puts "Deploying to Heroku"
  Rake::Task['deploy:to_staging']
  puts "Viewing in your browser..."
  system 'heroku open'
end

desc "Runs all of the tests for psychedeli.ca"
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

# Defaults to `compile`
task :default => :compile
