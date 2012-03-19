# = StatusExchange
#
# A Rack app that provides an aggregate status message feed from a number of
# social networks. Status messages from Facebook, Twitter, Soundcloud and
# GitHub are sorted by date into a single JSON array which is both simple
# and efficient to parse from a JavaScript client. It was designed for use
# with the jQuery.ticker plugin in use on the frontend of +psychedeli.ca+.
#
# == Supported services
#
# - Twitter
# - Facebook
# - GitHub
#
# == Configuration
#
# Reads from cfg/status_exchange.yml
#
# Author:: Tom Scott
# Homepage:: http://psychedeli.ca/

require 'status_exchange/facebook_client'
require 'status_exchange/twitter_client'
require 'status_exchange/application'

module StatusExchange
  class << self
    def config
      YAML::load_file(File.expand_path('./cfg/status_exchange.yml')).symbolize_keys!
    end
  end
end
