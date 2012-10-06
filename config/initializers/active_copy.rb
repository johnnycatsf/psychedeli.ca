require 'active_copy'

# Add the Markdown template handler.
ActionView::Template.register_template_handler :md, ActiveCopy::Template

module ActionView
  class Renderer
    def render context, options
      case true
      when options.key?(:partial) then render_partial context, options
      when options.key?(:copy) then render_copy context, options
      else
        render_template context, options
      end
    end

    def render_copy context, options, &block
      _copy_renderer.render context, options, block
    end

  private
    def _copy_renderer
      @_copy_renderer ||= ActiveCopy::Renderer.new @lookup_context
    end
  end
end
