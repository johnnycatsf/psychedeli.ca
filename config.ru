#
# dependencies
#
require 'rack'
require 'rack/jekyll'
require File.join(File.dirname(__FILE__), 'lib', 'status_exchange')
require 'sprockets'

# Sprockets asset management
map '/files' do
  assets = Sprockets::Environment.new
  assets.append_path 'css'
  assets.append_path 'js'
  assets.append_path 'img'
  assets.append_path 'swf'
  run assets
end

# StatusExchange ticker service
map '/status.json' do
  status_exchange = StatusExchange.new
  run status_exchange
end

# The static Jekyll site
map '/' do
  run Rack::Jekyll.new(:destination => 'pub')
end