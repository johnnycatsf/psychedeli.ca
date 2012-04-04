require 'test_helper'

class GithubClientTest < UnitTest
  setup {
    VCR.use_cassette "github_feed" do
      @github = StatusExchange::GithubClient.new
    end
  }

  should "have a neutral username" do
    assert_equal "test_user", @github.username
  end

  should "not have an empty activity feed" do
    refute_nil @github.activity
    assert_equal "tubbo created tag version/1.0.0  at tubbo/dots",
      @github.activity.first[:text]
  end
end
