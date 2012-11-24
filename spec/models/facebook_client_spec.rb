require 'test_helper'

describe "FacebookClient", ActiveSupport::TestCase do
  setup do
    @facebook = FacebookClient.new
  end

  it "retrieve the profile object set by vanity_url in config" do
    VCR.use_cassette "facebook_profile" do
      @facebook.connected?, @facebook.errors.full_messages.join(', ').should.not == nil
      @facebook.profile[:id].should == "20278681416"
    end
  end

  it "retrieve the most most recent activity" do
    VCR.use_cassette "facebook_posts" do
      @facebook.connected?, @facebook.errors.full_messages.join(', ').should.not == nil
      refute_empty @facebook.posts
    end
  end
end
