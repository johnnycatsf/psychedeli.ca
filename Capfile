require 'bundler'
Bundler.setup :default, :development
Bundler.require :development

load 'deploy' if respond_to?(:namespace) # cap2 differentiator

# Deploy configuration lives in the config dir
load 'cfg/deploy'
