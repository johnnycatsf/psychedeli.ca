# Uses the normal +ActionView+ template engines for Markdown and
# HAML, but wraps the given +Article+'s compiled HTML source with 
# the HAML template defined in its YAML Front Matter. This is used for the
# +rake articles:precompile+ task, for in Rails this type of rendering
# is accomplished using the framework. This class absorbs the task of
# creating the entire static HTML page from scratch for every single
# +Article+ that can be published.
module ActiveCopy
  class CompiledPage
    attr_reader :model, :haml

    # Create a new instance of this object.
    def initialize with_model
      @model = with_model
      @haml = ActionView::Template.registered_template_handler :haml
    end

    # Return the entire contents of the Article's liquid template layout.
    def layout
      @layout ||= haml.call begin
        if model.layout == "post"
          IO.read "#{Rails.root}/#{article_partial}"
        else
          IO.read "#{Rails.root}/#{layout_path}"
        end
      end
    end

    # Return the HTML generated for this Article.
    def html
      eval "b = #{layout}"
      b
      #haml.call layout do |html|
        #markdown.call article.source
      #end
    end

    # Render the Article to a file.
    def save
      mkdir_p article.path unless File.exists? article.path
      File.new(article.index_path, 'w') { |file| file.puts html }
      File.exists? article.index_path
    end

  private
    def article_partial
      "app/views/articles/_article.html.haml"
    end

    def layout_path
      "app/views/layouts/#{model.layout}.html.haml"
    end
  end
end
