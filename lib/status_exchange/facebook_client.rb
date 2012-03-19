module StatusExchange
  require 'active_support/all'
  require 'koala'

  class FacebookClient
    def initialize
      @config = StatusExchange.config[:facebook].symbolize_keys
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

    def is_defined?
      !!@config[:vanity_url]
    end

    def profile
      @graph.get_object(@config[:vanity_url]).symbolize_keys!
    end

    def method_missing api_call, *options, &block
      @graph.get_connections @config[:vanity_url], api_call.to_s
    end
  end
end
