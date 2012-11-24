# Interfaces with Twitter to provide any tweets the user writes.
class TwitterClient
  # Set up Twitter authentication.
  def initialize
    @config = StatusConfig[:twitter]
    @user = @config[:user_name]
  end

  # Return all tweets in the timeline in an array of Hashes, using
  # the standard status.json syntax.
  def tweets
    timeline.reduce([]) { |statuses,tweet|
      statuses << {
        message: tweet.text,
        date: tweet.created_at,
        service: 'twitter'
      }
      statuses
    }.first(5)
  end

private
  # Make the call to Twitter to provide our user's timeline.
  def timeline
    @user_timeline ||= Twitter.user_timeline(@user)
  end
end
