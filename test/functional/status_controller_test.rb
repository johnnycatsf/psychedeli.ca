require 'test_helper'

class StatusControllerTest < ActionController::TestCase
  setup { @controller = StatusController.new }

  context "StatusController: GET /status.json" do
    setup do 
      VCR.use_cassette(:all_services) do
        get :index, format: :json
      end
    end

    test "accept JSON requests" do
      assert_equal 200, response.status
    end

    test "respond with an array of JSON objects" do
      statuses = JSON.parse response.body
      refute_empty statuses
    end
  end

  %w(html xml).each do |fmt|
    context "StatusController: GET /status.#{fmt}" do
      setup do
        VCR.use_cassette(:all_services) do
          get :index, format: fmt.to_sym
        end
      end

      test "reject #{fmt.upcase} requests" do
        assert_equal 406, response.status
      end

      test "respond with a blank body" do
        assert response.body.blank?, "Body has content"
      end
    end
  end
end
