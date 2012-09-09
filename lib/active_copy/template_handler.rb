# Initialize Markdown templating for +ActionView+. Use the
# +Compiler+ class to actually do the heavy lifting, but add
# another method called +call_with_layout()+, which
# basically wraps a Liquid layout around the Markdown call. This is for
# precompilation in the Rake task.
module ActiveCopy
  module TemplateHandler
    # Instantiate the handler for Liquid templates
    def self.liquid
      @liquid ||= ActionView::Template.registered_template_handler :liquid
    end

    # Render the template with ArticleCompiler.
    def self.call template
      liquified_template = liquid.call template

      <<-RUBY
        markdown = ActiveCopy::Markdown.new
        markdown.render(begin;#{erbified_template};end).to_html
      RUBY
    end

    # Return the source in a String for the given layout filename.
    def self.layout
      @layout ||= begin
        if @layout_name.present?
          IO.read "#{Rails.root}/app/views/layouts/#{@layout_name}.html.liquid"
        else
          raise ArgumentError.new "Layout name not set"
        end
      end
    end
  end
end

