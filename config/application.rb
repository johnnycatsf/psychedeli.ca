$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "sprockets/railtie"

require 'bundler'
require 'pry' if Rails.env.development?
Bundler.require :default, *Rails.groups(:assets => %w(development test))

require 'link_to_tent'
require 'active_copy'

module Psychedelica
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += Dir["#{config.root}/lib/**", "#{config.root}/lib/**/**"]
                              .select { |path| File.directory? path }
                              .reject { |path| path =~ /generators|tasks/ }
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
    # config.time_zone = 'Central Time (US & Canada)'
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true
    # config.active_record.schema_format = :sql

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Generate Haml instead of ERb and Factories instead of fixtures
    config.generators do |g|
      g.template_engine :haml
      g.test_framework :test_unit, fixtures: false, fixture_replacement: :factory_girl
    end

    # Configure metadata from YAML
    config.metadata = YAML::load_file("#{Rails.root}/config/metadata.yml")

    # Route Tent requests to our tentd on psychedeli.ca
    config.middleware.use LinkToTent
  end
end
