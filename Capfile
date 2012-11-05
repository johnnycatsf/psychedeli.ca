require 'bundler'

Bundler.require :deployment

Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

load 'deploy'
load 'deploy/assets'

load 'config/deploy'
