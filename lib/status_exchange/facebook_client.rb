require 'active_support/all'
require 'koala'

module StatusExchange
  class FacebookClient
    def initialize config
      @config = config.symbolize_keys!
      @graph = Koala::Facebook::Client.new @config[:access_token]
    end

    def connected?
      begin
        @graph.get_connections(@config[:user_name], "comments")
        true
      rescue Koala::Facebook::GraphAPIError
        false
      end
    end

    def profile
    end

    def posts
    end
  end
end
