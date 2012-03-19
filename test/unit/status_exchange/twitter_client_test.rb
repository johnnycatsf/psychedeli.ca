require 'test_helper'

class StatusExchange::TwitterClientTest < ActiveSupport::TestCase
  setup do
    @twitter = StatusExchange::TwitterClient.new yaml_config[:twitter]
  end

  test "gets the top five latest tweets from twitter" do
    VCR.use_cassette "twitter_timeline" do
      refute_empty @twitter.tweets
    end
  end
end
