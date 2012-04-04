require 'active_support/all'
require 'twitter'

module StatusExchange
  class TwitterClient
    def initialize
      @config = StatusExchange.config[:twitter].symbolize_keys
      @user = @config[:user_name]
    end

    def tweets
      timeline.reduce([]) { |statuses,tweet|
        statuses << {
          message: tweet.text,
          date: tweet.created_at,
          service: 'twitter'
        }
        statuses
      }
    end

    private

    def timeline
      Twitter.user_timeline(@user)
    end
  end
end
