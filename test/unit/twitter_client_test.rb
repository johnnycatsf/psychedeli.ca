require 'test_helper'

class TwitterClientTest < ActiveSupport::TestCase
  setup do
    @twitter = TwitterClient.new
  end

  test "get the five most recently posted tweets" do
    VCR.use_cassette "twitter_timeline" do
      refute_empty @twitter.tweets
      assert_equal 5, @twitter.tweets.count
    end
  end
end
