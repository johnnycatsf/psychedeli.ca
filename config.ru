# = psychedeli.ca rackup
#
# This is the rackup file for http://psychedeli.ca/
#
# It describes to Rack how each request should be served. For example, all
# requests to +http://psychedeli.ca/status.json+ should be handled by
# StatusExchange, but otherwise the requested path should just be looked up
# in the pub/ folder. This rackup was designed to facilitate development of
# my blog on Rack servers like Pow, but I later modified it for use with my
# StatusExchange provider to give an extra level of information to my blog's
# home page.
#
# Author:: Tom Scott

if ENV['MY_RUBY_HOME'] && ENV['MY_RUBY_HOME'].include?('rvm')
  begin
    require 'rvm'
    RVM.use_from_path! File.dirname(File.dirname(__FILE__))
  rescue LoadError
    raise "RVM gem is currently unavailable."
  end
end

require 'bundler'
Bundler.setup :framework, :assets
Bundler.require :framework, :assets

# $LOAD_PATH << './lib'
# require 'status_exchange'

require 'rack/contrib/try_static'
require 'rack/contrib/not_found'

# Log everything
use Rack::CommonLogger

# Compile stylesheets
map '/css' do
  stylesheets = Sprockets::Environment.new
  # stylesheets.append_path Compass::Frameworks['bootstrap'].templates_directory + '/../vendor/assets/javascripts'
  stylesheets.append_path 'app/css'
  run stylesheets
end

# Compile javascripts
map '/js' do
  javascripts = Sprockets::Environment.new
  javascripts.append_path 'app/js'
  run javascripts
end

# Compile Handlebars templates (we don't have any right now)
# map '/tmpl' do
#   templates = Sprockets::Environment.new
#   templates.append_path 'assets/templates' # for Handlebars templates
#   templates.append_path HandlebarsAssets.path
#   run templates
# end

# Manage images
map '/img' do
  images = Sprockets::Environment.new
  images.append_path 'app/img'
  run images
end

# JSON feed server
#use StatusExchange::Application

# Static site handler
use Rack::TryStatic,
    :root => "pub",  # static files root dir
    :urls => %w[/],     # match all requests
    :try => ['.html', 'index.html', '/index.html'] # try these postfixes sequentially
run Rack::NotFound.new 'pub/index.html'
