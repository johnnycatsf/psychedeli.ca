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

$LOAD_PATH << './lib'

require 'rubygems'
require 'status_exchange'
require 'sprockets'
require 'rack/contrib/try_static'
require 'rack/contrib/not_found'

map '/css' do
  stylesheets = Sprockets::Environment.new
  stylesheets.append_path 'app/css'
  run stylesheets
end

map '/js' do
  javascripts = Sprockets::Environment.new
  javascripts.append_path 'app/js'
  run javascripts
end

map '/' do
  use StatusExchange::Application
  use Rack::TryStatic, root: 'pub', urls: %w[/], try: ['.html', 'index.html', '/index.html']
  run Rack::NotFound.new 'pub/index.html'
end
