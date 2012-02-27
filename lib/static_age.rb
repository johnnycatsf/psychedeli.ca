class StaticAge
  def call(env)
    use Rack::TryStatic,
      root: 'pub',
      urls: %w[/],
      try: ['.html', 'index.html', '/index.html']

    run lambda { [404, {'Content-Type' => 'text/html'}, ['Not Found']]}
  end
end
