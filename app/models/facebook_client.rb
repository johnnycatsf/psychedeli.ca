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

    def posts
      timeline.reduce([]) { |statuses, post|
        statuses << {
          message: post['story'] || post['message'],
          date: post['created_time'],
          service: 'facebook'
        }
        statuses
      }
    end

    private

    def timeline
      @graph.get_connections @config[:vanity_url], "posts"
    end
  end
end
