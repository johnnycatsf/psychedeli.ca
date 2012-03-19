require 'test_helper'

class StatusExchange::ApplicationTest < UnitTest
  setup do
    @app = StatusExchange::Application.new Rack::NotFound.new('pub/index.html')
  end

  test "instantiates a new json aggregator" do
    refute_empty @app.call Rack::MockRequest.new
  end

  context "requests to /status" do
    should "respond successfully" do
      refute_empty @app.call({
        'PATH_INFO' => "/status"
      })[2]
    end
  end

  context "any other request" do
    should "be relayed to the next rack application"
  end
end
