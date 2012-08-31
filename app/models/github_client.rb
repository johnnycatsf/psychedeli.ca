# Interfaces with Github to provide the activity ATOM feed in JSON.
class GithubClient
  attr_reader :username

  # Authenticate and obtain the feed from Github.
  def initialize
    @config = StatusConfig[:github]
    @username = @config[:user_name]
    @feed = Atom::Feed.load_feed \
      URI.parse "https://github.com/#{@username}.atom"
  end

  # Parse the activity feed into an Array of Hashes that
  # are accessible to status.json.
  def activity
    @feed.entries.reduce([]) {|entries, entry|
      entries << {
        message: entry.title,
        date: entry.published,
        service: 'github'
      }
    }
  end
end
