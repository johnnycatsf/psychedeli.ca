require 'test_helper'

class StatusExchangeTest < ActiveSupport::FunctionalTestCase
  include Rack::Test::Methods

  setup { @app = StatusExchange::Application.new }

  context "requests to /status get routed to StatusExchange" do
    get "/status"
    assert_equal "http://example.org/status", last_request.url
    assert last_response.ok?
  end
end
