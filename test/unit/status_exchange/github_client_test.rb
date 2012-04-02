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
end
