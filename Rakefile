require 'bundler'
Bundler.setup :default, :development
Bundler.require :development

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

desc "Runs the server, which is Thin in development and Unicorn in production"
task :server do
  server =  if ENV['RACK_ENV'] == 'production'
              { name: 'Unicorn', command: 'unicorn -p 3000 -D' }
            else
              Rake::Task[:compile].invoke
              { name: 'Thin', command: 'thin -p 3000 start' }
            end

  puts "Starting #{server[:name]}..."
  system server[:command]
end

desc "Run the test suite"
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
end

# namespace :javascript do
#   desc "Compiles static javascript assets"
#   Rake::SprocketsTask.new do |t|
#     t.environment = Sprockets::Environment.new
#     t.output      = "./pub/js"
#     t.assets      = %w( application.js )
#   end
# end

# namespace :stylesheet do
#   desc "Compiles static stylesheet assets"
#   Rake::SprocketsTask.new do |t|
#     t.environment = Sprockets::Environment.new
#     t.output      = "./pub/css"
#     t.assets      = %w( psychedelica.css.scss )
#   end
# end

desc "Run the test suite on CI"
task :build => [:compile, :config, :test]

# desc "Build the site, test the code and restart the server"
task :default => [:compile, :test, :restart]
