#
# dependencies
#
require 'rack'
require 'rack/contrib/try_static'
require './lib/status_exchange'
require 'sprockets'

# Sprockets asset management
map '/assets' do
  assets = Sprockets::Environment.new
  assets.append_path 'css'
  assets.append_path 'js'
  run assets
end

# StatusExchange ticker service
map '/status.json' do
  status_exchange = StatusExchange.new
  run status_exchange
end

# The static Jekyll site
map '/' do
  run Rack::TryStatic, :root => 'pub', :urls => %w[/], :try => ['.html', 'index.html', '/index.html']
  run lambda { [404, {'Content-Type' => 'text/html'}, ['404: Request Not Found']]}  # otherwise 404
end