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
require 'autocorrect'
require 'sprockets'
require 'rack/contrib/try_static'
require 'rack/contrib/not_found'

#use Rack::EY::Solo::DomainRedirect                # redirects www.psychedeli.ca to psychedeli.ca

map '/css' do
  stylesheet_environment = Sprockets::Environment.new
  stylesheet_environment.append_path 'app/css'
  run stylesheet_environment
end

map '/js' do
  javascript_environment = Sprockets::Environment.new
  javascript_environment.append_path 'app/js'
  run javascript_environment
end

map '/' do
  #use StatusExchange
  use Rack::TryStatic,
    root: 'pub',
    urls: %w[/],
    try: ['.html', 'index.html', '/index.html']
  run Rack::NotFound
end
