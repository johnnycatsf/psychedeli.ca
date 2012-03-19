require 'active_support/all'
require 'twitter'

module StatusExchange
  class TwitterClient
    def initialize with_config
      @config = with_config.symbolize_keys
    end

    def tweets
      Twitter.user_timeline @config[:user_name]
    end
  end
end
