require 'active_support/all'
require 'date'
require 'json'
require 'rack/contrib/not_found'

module StatusExchange
  class Application
    def initialize application=nil, options={}
      @mount = options[:url] || '/status'
      @app = application
      @statuses = [] # an array of status messages

      @twitter = StatusExchange::TwitterClient.new
      @facebook = StatusExchange::FacebookClient.new
    end

    def call env
      if @mount == env['PATH_QUERY']
        status = 200
        headers = {"Content-Type" => "application/json"}

        @twitter.tweets.each {|tweet|
          @statuses << {
            message: tweet.text,
            date: tweet.created_at,
            service: 'twitter'
          }
        }

        @facebook.posts.each {|post|
          @statuses << {
            message: post.message || post.story,
            date: post.date,
            service: 'facebook'
          }
        }

        body = @statuses.to_json
      else
        status, headers, body = @app.call env
      end

      [status, headers, body]
    end
  end
end
