# StatusExchange
# ==============
#
# StatusExchange is a Rack app that spits out JSON with the latest updates from the following social platforms:
#
# - Twitter
# - Facebook
# - GitHub
#
# Author:: Tom Scott
# Homepage:: http://psychedeli.ca/

require 'twitter'
require 'mogli'
require 'atom'

class StatusExchange
  def initialize(config)
    @twitter = Struct.new(tweets: Twitter.user_timeline('tubbo'))

    fb_client = Mogli::Client.new(CFG['facebook']['access_token'])
    @facebook = Mogli::User.find('me', facebook)

    sc_client = Soundcloud.new(:client_id => CFG['soundcloud']['client_id'])
    @soundcloud = sc_client.get('/resolve', url: 'http://soundcloud.com/wonderbars')

    @github = Atom::Feed.load_feed(URI.parse("https://github.com/tubbo.atom"))
  end

  def call(env)
    @tweets.each do |tweet|
      statuses << {
        message: tweet.text,
        date: DateTime.parse(tweet.created_at),
        link: "https://twitter.com/tubbo/status/#{tweet.id}",
        type: 'twitter'
      }
    end

    @facebook.posts.each do |post|
      statuses << {
        message: post.story,
        date: DateTime.parse(post.created_time),
        link: post.link,
        type: 'facebook'
      }
    end

    @github.each_entry do |entry|
      statuses << {
        message: entry.title,
        date: DateTime.parse(entry.updated),
        link: entry.link,
        type: 'github'
      }
    end

    @soundcloud.tracks.each do |track|
      statuses << {
        message: "posted #{track.title} on Soundcloud.",
        date: DateTime.parse(track.created_at),
        link: track.permalink_url,
        type: 'soundcloud'
      }
    end

    @soundcloud.comments.each do |comment|
      commented_track = @sc_client.get('/track', id: comment.track_id)
      statuses << {
        message: "commented on #{commented_track.title}",
        date: DateTime.parse(comment.created_at),
        link: commented_track.permalink_url,
        type: 'soundcloud'
      }
    end

    statuses << soundcloud_statuses
    statuses.sort {|this_status,next_status| this_status.date <=> next_status.date }

    # respond as JSON
    [ 200, {'Content-Type' => 'application/json'}, statuses.to_json ]
  end
end
