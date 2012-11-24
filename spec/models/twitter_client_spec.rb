require 'test_helper'

describe "TwitterClient", ActiveSupport::TestCase do
  setup do
    @twitter = TwitterClient.new
  end

  it "get the five most recently posted tweets" do
    VCR.use_cassette "twitter_timeline" do
      refute_empty @twitter.tweets
      @twitter.tweets.count.should == 5
    end
  end
end
