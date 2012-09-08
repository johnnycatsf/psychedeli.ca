# Uses the normal +ActionView+ template engines for Markdown and
# HAML, but wraps the given +Article+'s compiled HTML source with 
# the HAML template defined in its YAML Front Matter. This is used for the
# +rake articles:precompile+ task, for in Rails this type of rendering
# is accomplished using the framework. This class absorbs the task of
# creating the entire static HTML page from scratch for every single
# +Article+ that can be published.
module ActiveCopy
  class CompiledPage
    attr_reader :article, :layout_template_engine

    # Create a new instance of this object.
    def initialize with_article
      @article = with_article
      @haml = ActionView::Template.registered_template_handler :haml
    end

    # Return the entire contents of the Article's liquid template layout.
    def layout
      @layout ||= if article.layout == "post"
                    IO.read "#{Rails.root}/app/views/articles/_article.html.haml"
                  else
                    IO.read "#{Rails.root}/app/views/layouts/#{article.layout}.html.haml"
                  end
    end

    # Return the HTML generated for this Article.
    def html
      haml.call layout do
        markdown.call article.source
      end
    end

    # Render the Article to a file.
    def save
      mkdir_p article.path unless File.exists? article.path
      File.new(article.index_path, 'w') { |file| file.puts html }
      File.exists? article.index_path
    end
  end
end
