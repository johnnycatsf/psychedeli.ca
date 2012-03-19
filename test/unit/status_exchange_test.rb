require 'rack/contrib/not_found'
require 'test_helper'

class StatusExchangeTest < ActiveSupport::TestCase
  setup do
    @app = StatusExchange.new(Rack::NotFound.new('pub/index.html'))
  end

  test "gets the top five latest tweets from twitter" do
    VCR.use_cassette "twitter" do
      refute_empty @app.last_five_twitter_tweets, "Must return tweets"
    end
  end

  # test "gets the top five latest status messages from facebook" do
  #   refute_empty @app.last_five_facebook_posts, "Must return Facebook status messages"
  # end

  # test "gets the top five entries to the github timeline" do
  #   skip
  # end
end
