module Psychedelica
  class Application
    config.status_config_path = "#{Rails.root}/config/status_exchange.yml"
    config.status_providers = HashWithIndifferentAccess.new \
      YAML::load_file(config.status_config_path)[Rails.env]
  end
end

StatusConfig = Psychedelica::Application.config.status_providers
