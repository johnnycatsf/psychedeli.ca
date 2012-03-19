module StatusExchange
  require 'active_support/all'
  require 'koala'

  class FacebookClient
    def initialize config
      @config = config.symbolize_keys!
      @graph = Koala::Facebook::API.new @config[:access_token]
    end

    def connected?
      begin
        @graph.get_connections(@config[:vanity_url], "comments")
        true
      rescue Koala::Facebook::APIError
        false
      end
    end

    def profile
      @graph.get_object(@config[:vanity_url]).symbolize_keys!
    end

    def method_missing api_call, *options, &block
      @graph.get_connections @config[:vanity_url], api_call.to_s
    end
  end
end
