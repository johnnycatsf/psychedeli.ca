class FacebookClient
  # Authenticate with Facebook.
  def initialize
    @config = StatusConfig[:facebook]
    @graph = Koala::Facebook::API.new @config[:access_token]
  end

  # Test if this client is connected to Facebook.
  def connected?
    begin
      @graph.get_connections(@config[:vanity_url], "comments")
      true
    rescue Koala::Facebook::APIError
      false
    end
  end

  # Test if the vanity URL for the given user is defined.
  def is_defined?
    !!@config[:vanity_url]
  end

  # Return the user's basic Facebook information
  # in a symbolized-key Hash.
  def profile
    @graph.get_object(@config[:vanity_url]).symbolize_keys!
  end

  # Return the user's Facebook posts in an Array of Hashes that
  # status.json can accept.
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

  # Obtain the timeline for the given type. Defaults to "posts"
  def timeline(type=:posts)
    @graph.get_connections @config[:vanity_url], "posts".to_s
  end
end
