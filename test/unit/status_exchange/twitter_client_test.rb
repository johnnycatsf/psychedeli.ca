require 'test_helper'
require 'status_exchange'

class TwitterClientTest < UnitTest
  setup do
    @twitter = StatusExchange::TwitterClient.new
  end

  should "get the five most recently posted tweets" do
    VCR.use_cassette "twitter_timeline" do
      refute_empty @twitter.tweets
      # assert_equal @twitter.tweets.first
    end
  end
end
