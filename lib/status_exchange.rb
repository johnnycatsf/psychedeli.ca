# = StatusExchange
#
# A Rack app that provides an aggregate status message feed from a number of
# social networks. Status messages from Facebook, Twitter, Soundcloud and
# GitHub are sorted by date into a single JSON array which is both simple
# and efficient to parse from a JavaScript client. It was designed for use
# with the jQuery.ticker plugin in use on the frontend of my blog,
# <http://psychedeli.ca/>
#
# To customize how StatusExchange JSON is displayed, check out the source for
# jQuery.ticker: <http://github.com/tubbo/jquery.ticker>
#
# == Supported services
#
# The following APIs are connected to and sorted in a standard JSON feed:
#
# - Twitter
# - Facebook
#
# Future support planned for: GitHub, Soundcloud, Last.FM
#
# == Configuration
#
# StatusExchange reads its configuration from an external YAML file, located at
# <tt>cfg/status_exchange.yml</tt>. An example file is provided in that folder,
# meant for you to rename and configure with your own registered app settings.
# You will need to register your own app for Soundcloud and Facebook, and
# provide personal authentication details in order to configure StatusExchange
# properly.
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
