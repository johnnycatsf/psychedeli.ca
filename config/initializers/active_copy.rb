require 'active_copy'

# Add the Markdown template handler.
ActionView::Template.register_template_handler :md, ActiveCopy::TemplateHandler

# Extend the +render()+ method to render copy from app/documents.
module ActionView
  module Helpers
    module RenderingHelper
      include ActiveCopy::ViewHelper

      def render *args
        if args.first.is_a? Hash and args.first[:copy].present?
          filename = args.first.delete :copy
          render_markdown filename, *args
        else
          super
        end
      end
    end
  end
end
