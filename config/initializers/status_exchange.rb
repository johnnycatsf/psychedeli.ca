module Psychedelica
  class Application
    config.status_providers = if Rails.env == 'stage'
      environment_defines_config!
    else
      status_config_path = "#{Rails.root}/config/status_exchange.yml"

      if File.exists? status_config_path
        HashWithIndifferentAccess.new YAML::load_file(status_config_path)[Rails.env]
      else
        environment_defines_config!
      end
    end

    def environment_defines_config!
      {
        twitter: { user_name: ENV['TWITTER_USER_NAME'] },
        facebook: {
          app_id: ENV['FACEBOOK_APP_ID'],
          app_secret: ENV['FACEBOOK_APP_SECRET'],
          access_token: ENV['FACEBOOK_ACCESS_TOKEN'],
          vanity_url: ENV['FACEBOOK_VANITY_URL']
        },
        github: { user_name: ENV['GITHUB_USER_NAME'] }
      }
    end
  end
end

StatusConfig = Psychedelica::Application.config.status_providers
