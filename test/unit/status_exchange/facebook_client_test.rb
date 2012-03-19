require 'test_helper'

class StatusExchange::FacebookClientTest < ActiveSupport::TestCase
  setup do
    @facebook = StatusExchange::FacebookClient.new yaml_config[:facebook]
  end

  test "connects to facebook with the proper oauth credentials" do
    VCR.use_cassette "facebook_comments" do
      assert @facebook.connected?
    end
  end

  test "retrieves the profile of tubbo" do
    VCR.use_cassette "facebook_profile" do
      assert_equal "1473930052", @facebook.profile[:id]
    end
  end

  test "retrieves the last five status messages posted by tubbo" do
    VCR.use_cassette "facebook_status_messages" do
      refute_empty @facebook.posts
    end
  end
end
