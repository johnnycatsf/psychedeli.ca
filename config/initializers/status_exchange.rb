module StatusExchange
  class << self
    def config
      YAML::load_file(File.expand_path("#{Rails.root}/config/status_exchange.yml")).symbolize_keys!
    end
  end
end
