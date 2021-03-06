$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require File.expand_path('../boot', __FILE__)

require 'bundler/setup'

require 'action_controller/railtie'
require 'sprockets/railtie'

require 'link_to_tent'
require 'active_copy'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require :default, :assets, :views, Rails.env

module Psychedelica
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Generate Haml templates and RSpec tests
    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec, fixtures_directory: 'spec/fixtures'
    end

    # Route Tent requests to the tentd on psychedeli.ca
    config.middleware.use LinkToTent

    config.metadata = YAML::load_file "#{Rails.root}/config/metadata.yml"
  end
end
