require 'action_view'

# Helper methods for the view layer. Some of these methods are
# integrated directly into +ActionView+.
module ActiveCopy
  module ViewHelper
    # Extend +ActionView+'s render calls so we can render documents from
    # the view layer as if they were templates. Uses +render copy:
    # "relative/path"+ to look up the Markdown file and display it.
    def render_markdown relative_path, options, locals, &block
      template = "/app/documents/#{relative_path}.md"
      render template, options.merge(layout: false), locals, &block
    end
  end
end


