require 'active_support/all'
require 'date'
require 'json'
require 'rack/contrib/not_found'

module StatusExchange
  class Application
    def initialize application, options={}
      @mount = options[:url] || '/status'
      @app = application
      @statuses = [] # an array of status messages
    end

    def call env
      request = Rack::Request.new env

      if request.get? && @mount == request.path_info
        status = 200
        headers = {"Content-Type" => "application/json"}

        if twitter.is_defined?
          twitter.tweets.each {|tweet|
            @statuses << {
              message: tweet.text,
              date: tweet.created_at,
              service: 'twitter'
            }
          }
        end

        if facebook.is_defined?
          facebook.posts.each {|post|
            @statuses << {
              message: post.message || post.story,
              date: post.date,
              service: 'facebook'
            }
          }
        end

        body = @statuses.to_json
      else
        status, headers, body = @app.call env
      end

      [status, headers, body]
    end

    def twitter
      StatusExchange::TwitterClient.new
    end

    def facebook
      StatusExchange::FacebookClient.new
    end
  end
end
