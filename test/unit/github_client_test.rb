require 'test_helper'

class GithubClientTest < ActiveSupport::TestCase
  setup {
    VCR.use_cassette "github_feed" do
      @github = GithubClient.new
    end
  }

  should "have a username" do
    assert_equal "dhh", @github.username
  end

  should "not have an empty activity feed" do
    refute_nil @github.activity
    refute_empty @github.activity
  end
end
