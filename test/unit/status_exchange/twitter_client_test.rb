require 'test_helper'

class StatusExchange::TwitterClientTest < ActiveSupport::TestCase
  setup do
    @twitter = StatusExchange::TwitterClient.new yaml_config[:twitter]
  end

  context "connecting to the twitter api" do
    should "get the five most recently posted tweets" do
      VCR.use_cassette "twitter_timeline" do
        refute_empty @twitter.tweets
      end
    end
  end
end
