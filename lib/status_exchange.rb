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
require 'mogli'
require 'soundcloud'
require 'atom'
require 'date'
require 'json'
require 'yaml'

class StatusExchange
  attr_reader :statuses

  def initialize(application, options)
    @config = options[:config] || YAML::load_file(File.expand_path('./cfg/status_exchange.yml'))
    @mount = options[:url]
    @app = application
    @statuses = [] # an array of status messages
  end

  def call(env)
    if env['PATH_INFO'] == @mount
      # fb_client = Mogli::Client.new(@config['facebook']['access_token'])
      # facebook = Mogli::User.find('me', facebook)

      # sc_client = Soundcloud.new(:client_id => @config['soundcloud']['client_id'])
      # soundcloud = sc_client.get('/resolve', url: "http://soundcloud.com/#{@config['soundcloud']['user_name']}")

      # github = Atom::Feed.load_feed(URI.parse("https://github.com/#{@config['github']['user_name']}.atom"))

      # tweets.each do |tweet|
      #   @statuses << {
      #     message: tweet.text,
      #     #date: tweet.created_at,
      #     link: "https://twitter.com/tubbo/status/#{tweet.id}",
      #     type: 'twitter'
      #   }
      # end

      @statuses = tweets.reduce([]) {|tweets, tweet|
        tweets << {
          message: tweet.text,
          date: tweet.created_at,
          link: "https://twitter.com/tubbo/status/#{tweet.id}"
        }
      }

      # facebook.posts.each do |post|
      #   @statuses << {
      #     message: post.story,
      #     date: DateTime.parse(post.created_time),
      #     link: post.link,
      #     type: 'facebook'
      #   }
      # end

      # github.each_entry do |entry|
      #   @statuses << {
      #     message: entry.title,
      #     date: DateTime.parse(entry.updated),
      #     link: entry.link,
      #     type: 'github'
      #   }
      # end

      # soundcloud.tracks.each do |track|
      #   @statuses << {
      #     message: "posted #{track.title} on Soundcloud.",
      #     date: DateTime.parse(track.created_at),
      #     link: track.permalink_url,
      #     type: 'soundcloud'
      #   }
      # end

      # soundcloud.comments.each do |comment|
      #   commented_track = @sc_client.get('/track', id: comment.track_id)
      #   @statuses << {
      #     message: "commented on #{commented_track.title}",
      #     date: DateTime.parse(comment.created_at),
      #     link: commented_track.permalink_url,
      #     type: 'soundcloud'
      #   }
      # end

      # sort by date
      @statuses.sort {|this_status,next_status| this_status[:date] <=> next_status[:date] }

      statuses_as_json = [{:statuses => @statuses}.to_json]

      # return as JSON
      [ 200, {'Content-Type' => 'application/json'}, statuses_as_json ]
    else
      @app.call(env)
    end
  end

  def tweets
    Twitter.user_timeline(@config['twitter']['user_name'])
  end
end
