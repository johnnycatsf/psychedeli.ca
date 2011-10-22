#
# dependencies
#
require 'rack'
require 'rack/contrib/try_static'
require 'lib/status_exchange'

#
# frontend
#
use Rack::TryStatic,
  :root => 'pub',
  :urls => %w[/],
  :try => ['.html', 'index.html', '/index.html']
use StatusExchange
# otherwise 404
run lambda { [404, {'Content-Type' => 'text/html'}, ['404: Request Not Found']]}