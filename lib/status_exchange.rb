# StatusExchange
# ==============
#
# StatusExchange is a Rack app that spits out JSON with the latest updates from the following social platforms:
#
# - Twitter
# - Facebook
# - GitHub
#
# Author:: Tom Scott
# Homepage:: http://psychedeli.ca/

require 'twitter'
require 'mogli'

class StatusExchange
  # Runtime
  def call(env)
    # get the last 10 status messages from Twitter
    Twitter.user_timeline('tubbo').each do |tweet|
      statuses << { message: tweet.text, date: tweet.created_at, type: 'twitter' }
    end
    
    # get the last 10 timeline posts from Facebook
    facebook = Mogli::Client.new(facebook_access_token)
    my = Mogli::User.find('me', facebook)
    my.posts.each do |status|
      statuses << { message: status.text || status.post, date: status.timestamp, type: 'facebook' }
    end
    
    # get the last 10 activity posts from GitHub
    
    # respond as JSON
    [ 200, {'Content-Type' => 'application/json'}, @statuses.to_json ]
  end
end