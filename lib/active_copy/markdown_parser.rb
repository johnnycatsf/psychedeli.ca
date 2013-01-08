require 'redcarpet'

# Compiles a Markdown file using the +Redcarpet+ template engine. Used
# by +ActionView+ in +config/initializers/markdown.rb+ to initiate
# Markdown template compilation for files that are not already
# precompiled.
module ActiveCopy
  class MarkdownParser
    # Create a new session with the compiler.
    def initialize
      @options = { fenced_code_blocks: true }
    end

    # Return an HTML String containing the rendered output of the Markdown
    # source.
    def render markdown_source
      markdown.render "#{markdown_source}"
    end

  private
    def markdown
      Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    end
  end
end
