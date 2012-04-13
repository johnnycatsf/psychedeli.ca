module StatusExchange
  class Application
    def initialize application=false, options={}
      @mount = options[:url] || '/status'
      @app = application || Rack::NotFound.new('pub/err/404.html')
      @statuses = [] # an array of status messages
    end

    def call env
      request = Rack::Request.new env

      if request.get? && @mount == request.path_info
        status = 200
        headers = {"Content-Type" => "application/json"}

        @statuses = twitter.tweets + facebook.posts + github.activity

        body = @statuses.to_json
      else
        status, headers, body = @app.call env
      end

      [status, headers, body]
    end

    def twitter
      StatusExchange::TwitterClient.new
    end

    def facebook
      StatusExchange::FacebookClient.new
    end

    def github
      StatusExchange::GithubClient.new
    end
  end
end
