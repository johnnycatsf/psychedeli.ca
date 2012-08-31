class StatusController < ApplicationController
  respond_to :json

  def index
    @statuses = twitter.tweets + facebook.posts + github.activity
    respond_with @statuses.sort{ |s1,s2| s1[:date] >= s2[:date] }
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
