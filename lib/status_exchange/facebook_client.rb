# This thin wrapper around Koala simply maps method calls to the account
# specified by your Facebook access ID. So a call to `facebook.posts` is
# like doing
#
#    @graph = Koala::Facebook::API.new FACEBOOK_ACCESS_TOKEN
#    @graph.get_object FACEBOOK_PROFILE_RELATIVE_URL, "posts"
#
# Super simple, and easy to use!
#
# @author Tom Scott
# @package StatusExchange

require 'active_support/all'
require 'koala'

module StatusExchange
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
