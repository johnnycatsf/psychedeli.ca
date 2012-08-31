require 'test_helper'

class StatusControllerTest < ActionController::TestCase
  setup { @controller = StatusController.new }

  context "GET /status" do
    test "render the status feed in JSON" do
      VCR.use_cassette(:all_services) do
        get :index
      end

      assert_equal 200, response.status
    end
  end
end
