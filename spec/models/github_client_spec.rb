require 'test_helper'

describe "GithubClient", ActiveSupport::TestCase do
  setup {
    VCR.use_cassette "github_feed" do
      @github = GithubClient.new
    end
  }

  it "have a username" do
    @github.username.should == "dhh"
  end

  it "not have an empty activity feed" do
    refute_nil @github.activity
    refute_empty @github.activity
  end
end
