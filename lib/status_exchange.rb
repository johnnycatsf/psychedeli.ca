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

require 'twitter'
require 'koala'

require 'date'
require 'json'
require 'yaml'
require 'active_support/all'

require 'rack/contrib/not_found'
require 'status_exchange/facebook_client'
require 'status_exchange/twitter_client'

module StatusExchange
  class << self
    attr_reader :statuses

    def initialize application=nil, options={}
      @config = options[:config] || YAML::load_file(File.expand_path('./cfg/status_exchange.yml'))
      @mount = options[:url] || '/status'
      @app = application
      @headers = {"Content-Type" => "application/json"}
      @statuses = [] # an array of status messages

      @config.symbolize_keys!

      @twitter = StatusExchange::TwitterClient.new @config[:twitter]
      @facebook = StatusExchange::FacebookClient.new @config[:facebook]
    end

    # For testing support. Returns a new instance of StatusExchange with Rack::NotFound chained.
    def self.test_app
      new Rack::NotFound.new('pub/index.html')
    end

    def self.call env
      if env['PATH_INFO'] == @mount
        @statuses = @twitter.tweets.reduce([]) {|tweets, tweet|
          tweets << {
            message: tweet.text,
            date: tweet.created_at,
            link: "https://twitter.com/tubbo/status/#{tweet.id}"
          }
        }

        # sort by date
        @statuses.sort {|this_status,next_status| this_status[:date] <=> next_status[:date] }

        status = 200
        body = [{:statuses => @statuses}.to_json]
      else
        status, @headers, body = @app.call env
      end

      # always respond
      [status, @headers, body]
    end
  end
end
