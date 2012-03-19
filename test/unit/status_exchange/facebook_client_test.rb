class StatusExchange::FacebookClientTest < ActiveSupport::TestCase
  setup do
    facebook = StatusExchange::FacebookClient.new
  end

  test "connects to facebook with the proper oauth credentials" do
    assert facebook.connected?
  end

  test "retrieves the profile of tubbo" do
    assert_equal "tubbo", facebook.profile.url
  end

  test "retrieves the last five status messages posted by tubbo" do
    refute_empty facebook.posts
  end
end
