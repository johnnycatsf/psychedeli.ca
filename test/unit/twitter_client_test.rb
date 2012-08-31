require 'test_helper'

class TwitterClientTest < ActiveSupport::TestCase
  setup do
    @twitter = TwitterClient.new
  end

  should "get the five most recently posted tweets" do
    VCR.use_cassette "twitter_timeline" do
      refute_empty @twitter.tweets
      # assert_equal @twitter.tweets.first
    end
  end
end
