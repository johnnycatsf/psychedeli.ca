require 'spec_helper'

describe FacebookClient do
  subject { FacebookClient.new }

  it "retrieve the profile object set by vanity_url in config" do
    VCR.use_cassette "facebook_profile" do
      subject.should be_connected, "#{subject.errors.full_messages}"
      subject.profile[:id].should == "20278681416"
    end
  end

  it "retrieve the most most recent activity" do
    VCR.use_cassette "facebook_posts" do
      subject.should be_connected, "#{subject.errors.full_messages}"
      refute_empty subject.posts
    end
  end
end
