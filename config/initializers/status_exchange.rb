Psychedelica::Application.config.status_providers = {
  twitter: {
    user_name: ENV['TWITTER_USER_NAME'],
    consumer_key: ENV['TWITTER_CONSUMER_KEY'],
    consumer_secret: ENV['TWITTER_CONSUMER_SECRET'],
    oauth_token: ENV['TWITTER_ACCESS_KEY'],
    oauth_token_secret: ENV['TWITTER_ACCESS_SECRET']
  },
  facebook: {
    app_id: ENV['FACEBOOK_APP_ID'],
    app_secret: ENV['FACEBOOK_APP_SECRET'],
    access_token: ENV['FACEBOOK_ACCESS_TOKEN'],
    vanity_url: ENV['FACEBOOK_VANITY_URL']
  },
  github: { user_name: ENV['GITHUB_USER_NAME'] }
}

StatusConfig = Psychedelica::Application.config.status_providers

Twitter.configure do |config|
  config.consumer_key = StatusConfig[:twitter][:consumer_key]
  config.consumer_secret = StatusConfig[:twitter][:consumer_secret]
  config.oauth_token = StatusConfig[:twitter][:oauth_token]
  config.oauth_token_secret = StatusConfig[:twitter][:oauth_token_secret]
end
