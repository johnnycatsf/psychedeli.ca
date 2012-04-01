require 'test_helper'

class StatusExchange::ApplicationTest < UnitTest
  include Rack::Test::Methods

  def app
    StatusExchange::Application.new
  end

  should "respond successfully on GET '/status'" do
    get '/status'
    assert last_response.ok?
  end
end
