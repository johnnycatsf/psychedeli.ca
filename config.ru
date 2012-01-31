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
require 'rack/contrib'

use Rack::EY::Solo::DomainRedirect                # redirects www.psychedeli.ca to psychedeli.ca

map '/ass' do
  environment = Sprockets::Environment.new
  environment.append_path 'app/css'
  environment.append_path 'app/js'
  environment.append_path 'app/img'
  run environment
end

map '/status.json' do
  status_exchange_config = YAML::load_file(File.join(Dir.pwd, 'cfg', 'status_exchange.yml'))

  run StatusExchange, status_exchange_config
end

map '/' do
  use Rack::TryStatic,
    root: 'pub',
    urls: %w[/].
    try: ['.html', 'index.html', '/index.html']

  run lambda { [404, {'Content-Type' => 'text/html'}, ['Not Found']]}
end
