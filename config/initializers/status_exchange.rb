module Psychedelica
  class Application
    config.status_providers = HashWithIndifferentAccess.new \
      YAML::load_file("#{Rails.root}/config/status_exchange.yml")
  end
end

StatusConfig = Psychedelica::Application.config.status_providers
