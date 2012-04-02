require 'active_support/all'
require 'atom'

module StatusExchange
  class GithubClient
    attr_reader :username

    def initialize
      @config = StatusExchange.config[:github].symbolize_keys
      @username = @config[:user_name]
      @feed = Atom::Feed.load_feed \
        URI.parse "https://github.com/#{@username}.atom"
    end

    def activity
      @feed.entries.reduce([]) {|activities, entry|
        activities << {
          title: entry.title,
          content: entry.content,
          author: entry.authors.first,
          published: entry.published
        }
      }
    end
  end
end
