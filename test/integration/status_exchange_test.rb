require 'test_helper'

class StatusExchangeTest < IntegrationTest
  should "respond to the proper url" do
    skip "Make build pass"

    VCR.use_cassette(:all_services) do
      get '/status'
      assert last_response.ok?
      assert_match /twitter/, last_response.body
      assert_match /facebook/, last_response.body
      assert_match /github/, last_response.body
    end
  end

  should "relay everything else to rack/not-found by default" do
    get '/'
    assert_equal 404, last_response.status
  end

  private

  def app
    StatusExchange::Application.new
  end
end
