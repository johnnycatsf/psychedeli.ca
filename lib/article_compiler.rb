# Manages the +Redcarpet+ engine for a single instance of compiling an
# +Article+. Invoked by either the Rake task +articles:precompile+ or
# ActionView when rendering a file.

require 'redcarpet'

class ArticleCompiler
  # Create a new session with the compiler.
  def initialize
    @renderer = Markdown.new 
    @options = { auto_link: true }
  end

  # Return an HTML String containing the rendered output of the Markdown
  # source.
  def render article
    markdown.render article.source
  end

private
  def markdown
    @client ||= Markdown.new @renderer, @options
  end
end
