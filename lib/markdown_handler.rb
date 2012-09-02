require 'article_compiler'

# ActionView template handler.
module MarkdownHandler
  def self.erb
    @erb ||= ActionView::Template.registered_template_handler(:erb)
  end

  def self.call(template)
    erbified_source = erb.call(template)
    <<-RUBY
      compiler=ArticleCompiler.new
      compiler.render(begin;#{erbified_source};end).to_html
    RUBY
  end
end

ActionView::Template.register_template_handler :md, MarkdownHandler
