require 'test_helper'
require 'status_exchange'

class StatusExchange::TwitterClientTest < UnitTest
  setup do
    @twitter = StatusExchange::TwitterClient.new
  end

  context "connecting to the twitter api" do
    should "get the five most recently posted tweets" do
      VCR.use_cassette "twitter_timeline" do
        refute_empty @twitter.tweets
        # assert_equal @twitter.tweets.first
      end
    end
  end
end
