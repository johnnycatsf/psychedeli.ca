#
# dependencies
#

require "rack/jekyll"

map '/filez' do


map '/' do
  run Rack::Static.new(:public => 'pub')
end

#require File.join(File.dirname(__FILE__), 'lib', 'status_exchange')

# The StatusExchange ticker service is available at /status.json
# map '/status.json' do
#   status_exchange = StatusExchange.new
#   run status_exchange
# end
