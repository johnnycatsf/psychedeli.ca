# StaticAge
#
# A Rack app that compiles a Jekyll site and Sprockets assets on demand.
#
# Author:: Tom Scott
# Homepage:: http://psychedeli.ca

require 'jekyll'

class StaticAge
  def call(env)
    options = env[:options]
    @site = Jekyll::Site.new(options)
    [200, {"Content-Type" => 'text/html'}, @site.process]
  end
end
