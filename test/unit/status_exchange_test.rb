require 'test_helper'

class StatusExchange::ApplicationTest < ActiveSupport::TestCase
  setup { @app = StatusExchange.new }

  context "requests to /status" do
    should "respond with json" do
      assert_equal "application/json", @app.headers["Content-Type"]
    end
  end
end
