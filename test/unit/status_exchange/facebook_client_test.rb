require 'test_helper'

class StatusExchange::FacebookClientTest < ActiveSupport::TestCase
  setup do
    @facebook = StatusExchange::FacebookClient.new cfg[:facebook]
  end

  context "connecting to the facebook graph api" do
    should "connect to facebook with a valid access token" do
      VCR.use_cassette "facebook_comments" do
        assert @facebook.connected?
      end
    end

    should "retrieve the object at the vanity_url in config" do
      VCR.use_cassette "facebook_profile" do
        assert_equal "1473930052", @facebook.profile[:id]
      end
    end

    should "retrieve the most most recent activity" do
      VCR.use_cassette "facebook_posts" do
        refute_empty @facebook.posts
      end
    end
  end
end
