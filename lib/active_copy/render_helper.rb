module ActiveCopy
  module RenderHelper
    # Extend +ActionView+'s render calls so we can render documents from
    # the view layer as if they were templates.
    def render options={}, locals={}, &block
      if options[:document]
        relative_path = options[:document]
        render "/app/documents/#{relative_path}.md"
      else
        super options, locals, &block
      end
    end
  end
end

module ActionView
  module Helpers
    module RenderingHelper
      include ActiveCopy::RenderHelper
    end
  end
end
