# StatusExchange
# ==============
#
# StatusExchange is a Sinatra app that responds to '/status.json' with the latest updates from the following platforms:
#
# - Facebook
# - Twitter
# - Last.FM
# - Spotify
# - GitHub
#
# Author:: Tom Scott
# Homepage:: http://psychedeli.ca/

require 'sinatra'
require 'twitter'
require 'mogli'

CONFIG = YAML::load_file('_config.yml')

Twitter.configure do |config|
  config.consumer_key = CONFIG['twitter']['app']['token']
  config.consumer_secret = CONFIG['twitter']['app']['secret']
  config.oauth_token = CONFIG['twitter']['usr']['token']
  config.oauth_token_secret = CONFIG['twitter']['usr']['secret']
end

class StatusExchange < Sinatra::Base
  get '/status.json' do
    facebook_client = Mogli::Client.new(CONFIG['facebook']['access_token'])
    facebook = Mogli::User.find('me', facebook_client)
    
    twitter = Twitter.home_timeline
    
    github = GitHub.create
    
  end
    