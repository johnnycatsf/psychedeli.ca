module Psychedelica
  class Application
    ENV_CONFIG = {
      twitter: { user_name: ENV['TWITTER_USER_NAME'] },
      facebook: {
        app_id: ENV['FACEBOOK_APP_ID'],
        app_secret: ENV['FACEBOOK_APP_SECRET'],
        access_token: ENV['FACEBOOK_ACCESS_TOKEN'],
        vanity_url: ENV['FACEBOOK_VANITY_URL']
      },
      github: { user_name: ENV['GITHUB_USER_NAME'] }
    }

    config.status_providers = if Rails.env == 'stage'
      ENV_CONFIG
    else
      status_config_path = "#{Rails.root}/config/status_exchange.yml"

      if File.exists? status_config_path
        HashWithIndifferentAccess.new YAML::load_file(status_config_path)[Rails.env]
      else
        ENV_CONFIG
      end
    end
  end
end

StatusConfig = Psychedelica::Application.config.status_providers
Twitter.configure do |config|
  config.consumer_key = StatusConfig[:twitter][:consumer_key]
  config.consumer_secret = StatusConfig[:twitter][:consumer_secret]
  config.oauth_token = StatusConfig[:twitter][:oauth_token]
  config.oauth_token_secret = StatusConfig[:twitter][:oauth_token_secret]
end
