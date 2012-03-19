require 'test_helper'

class StatusExchange::ApplicationTest < ActiveSupport::TestCase
  setup do
    @app = StatusExchange::Application.new
  end

  context "requests to /status" do
    should "respond successfully" do
      refute_empty @app.call({
        'PATH_QUERY' => "/status"
      })[2]
    end
  end

  context "any other request" do
    should "be relayed to the next rack application"
  end
end
