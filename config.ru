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

require 'pathname'

ENV['BUNDLE_GEMFILE'] ||= File.expand_path("../../Gemfile", Pathname.new(__FILE__).realpath)
$LOAD_PATH << './lib'

require 'rubygems'
require 'bundler/setup'

# == Main application
#
# Uses Rack::Static to serve static files in the pub/ directory, which is where
# Jekyll stores all its contents.

require 'rack/static'

map '/' do
  run Rack::Static.new(:public => "#{Dir.pwd}/pub")
end

# == StatusExchange
#
# A status message feed server. Outputs aggregated statuses from Facebook,
# Twitter, Last.FM and GitHub into a single feed which is both simple and
# efficient to parse from a JavaScript client.

require 'status_exchange'

map '/status.json' do
  run StatusExchange.new
end
