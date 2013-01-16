require 'test_helper'

class FacebookClientTest < ActiveSupport::TestCase
  setup do
    @facebook = FacebookClient.new
  end

  test "retrieve the profile object set by vanity_url in config" do
    VCR.use_cassette "facebook_profile" do
      assert @facebook.connected?, @facebook.errors.full_messages.join(', ')
      assert_equal "20278681416", @facebook.profile[:id]
    end
  end

  test "retrieve the most most recent activity" do
    VCR.use_cassette "facebook_posts" do
      assert @facebook.connected?, @facebook.errors.full_messages.join(', ')
      refute_empty @facebook.posts
    end
  end
end
