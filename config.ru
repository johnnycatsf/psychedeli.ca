#
# dependencies
#
require 'rack'
require 'rack/contrib'
require 'rack/jekyll'
require File.join(File.dirname(__FILE__), 'lib', 'status_exchange')

# The StatusExchange ticker service is available at /status.json
map '/status.json' do
  status_exchange = StatusExchange.new
  run status_exchange
end

# Serve the static Jekyll site
run Rack::Jekyll.new(destination: 'pub')
