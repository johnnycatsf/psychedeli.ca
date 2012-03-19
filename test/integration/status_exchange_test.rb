require 'test_helper'

class RoutingTest < IntegrationTest
  context "GET /" do
    should "render the home page" do
      get "/"
      assert_response :success
      assert_select 'section#posts', @request.body
    end
  end

  context "GET /status" do
    should "render an aggregate social network status message feed sorted by date" do
      get "/status"
      assert_equal "http://blog.dev/status", @request.url
      assert last_response.ok?
      assert_response :success
    end
  end
end
