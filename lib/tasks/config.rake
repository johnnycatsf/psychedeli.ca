require 'fileutils'

include FileUtils

namespace :config do
  desc "Enable configuration for status update providers."
  task :status_providers do
    cp "#{Rails.root}/config/status_exchange.yml.example", "#{Rails.root}/config/status_exchange.yml"
  end
end

desc "Move all configuration to its rightful place."
task :config => ['config:status_providers']
