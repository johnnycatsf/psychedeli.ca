class StatusController < ApplicationController
  respond_to :json

  def index
    @statuses = twitter.tweets + facebook.posts + github.activity
    respond_with @statuses
  end

private
  def twitter
    TwitterClient.new
  end

  def facebook
    FacebookClient.new
  end

  def github
    GithubClient.new
  end
end
