class StaticAge
  def initialize(app, path, cache_control=nil)
    @file_handler = FileHandler.new(path, cache_control)
  end

  def call(env)
    case env['REQUEST_METHOD']
    when 'GET', 'HEAD'
      path = env['PATH_INFO'].chomp('/')
      if match = @file_handler.match?(path)
        env["PATH_INFO"] = match
        return @file_handler.call(env)
      end
    end

    @app.call(env)
  end
end
