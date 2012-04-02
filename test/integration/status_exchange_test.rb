require 'test_helper'
require 'status_exchange'

class StatusExchangeTest < IntegrationTest
  should "respond to the proper url" do
    VCR.use_cassette "everything" do
      get '/status'
      assert last_response.ok?
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
