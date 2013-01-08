# Initialize Markdown templating for +ActionView+. Use the
# +Compiler+ class to actually do the heavy lifting, but add
# another method called +call_with_layout()+, which
# basically wraps a Liquid layout around the Markdown call. This is for
# precompilation in the Rake task.

# Initialize Markdown templating for +ActionView+, using our own wrapped
# +Redcarpet+. The entire text of the template is split into an +Array+
# using the YAML front matter dividers as a key. The 3rd position in the
# array created by this split is what is used as the Markdown source.
module ActiveCopy
  module Template
    # Render the template with ArticleCompiler.
    def self.call template
      source = if template.respond_to? :split
        template.split("---\n")[2]
      else
        template.source.split("---\n")[2]
      end

      <<-RUBY
        markdown = ActiveCopy::MarkdownParser.new
        markdown.render(begin;#{source};end).to_html
      RUBY
    end
  end
end

