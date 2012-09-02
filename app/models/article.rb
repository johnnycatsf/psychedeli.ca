require 'yaml'

# A Markdown document in +app/documents/articles+. Articles can be
# compiled into HTML on-the-fly, as is the case in development, or
# as a predecate to deployment, as is the case in the production
# and stage environments. Regardless of when compilation takes place,
# this model is used to store information about a single article
# document in the folder. A helper class, +ArticlesCompiler+, is invoked
# by the Rake task as well as ActionView to actually compile the
# Markdown into HTML. Its functionality is extrapolated to a library so
# that both +ActionView+ and +Rake+ can use it in tandem.
class Article
  include ActiveModel::Naming
  include ActiveModel::Serialization

  attr_accessor :layout, :title, :category, :date, :tags, :id, :hn_item_id, :published
  attr_reader :attributes

  ARTICLES_PATH = "#{Rails.root}/app/documents/articles"
  TEST_ARTICLES_PATH = "#{Rails.root}/test/fixtures/articles"

  # Instantiate using the filename as an ID, write out attributes to
  # reader placements.
  def initialize with_filename
    @id = with_filename
    @attributes = yaml_front_matter
    @attributes.each { |attribute,value| send "#{attribute}=", value }
  end

  # Compile the template using ActionView to the public HTML file.
  def compile!
    markdown = ActionView::Template.registered_template_handler(:md)
    mkdir_p path unless File.exists? path
    File.new(index_path, 'rw+') { |f| f.puts markdown.render source }
  end

  # Test if the +Article+ has been compiled by checking whether
  # +Article.path+ returns anything.
  def compiled?
    path == ""
  end

  # Return absolute path to public HTML file.
  def index_path
    "#{path}/index.html"
  end

  # Return absolute path to public cached copy, or +""+ if the
  # Article hasn't been compiled.
  def path
    @public_path ||= if Rails.env.test?
                       "#{Rails.root}/tmp/site/#{relative_path}"
                     else
                       "#{Rails.root}/public/#{relative_path}"
                     end

    if File.exists? @public_path
      @public_path
    else
      ""
    end
  end

  # Return relative path with the Rails.root/public part out.
  def relative_path
    @rel_path ||= begin 
      date_array = id.split("-")[0..2]
      date_path = date_array.join("/")
      article_id = begin
        str = id.gsub date_array.join("-"), ''
        if str[0] == "-"
          str[1..-1] 
        else
          str
        end
      end
      "#{category}/#{date_path}/#{article_id}"
    end
  end

  # Return absolute path to Markdown file on this machine.
  def source_path
    @source_path ||= if Rails.env.test?
                       "#{TEST_ARTICLES_PATH}/#{@id}.md"
                     else
                       "#{ARTICLES_PATH}/#{@id}.md"
                     end
  end

  # Test if the Article file is present on this machine.
  def present?
    File.exists? source_path
  end

  # Return the raw String source of the Markdown document, including
  # the YAML front matter.
  def raw_source
    @raw ||= File.read source_path
  end

  # Return the String source of the Markdown document without the YAML
  # front matter. This is what is passed into ActionView to render the
  # Markdown from this file.
  def source
    @source ||= raw_source.split("---\n")[2]
  end

  # Find an +Article+ by its filename.
  def self.find by_filename
    Article.new by_filename
  end

  # Return every +Article+ in app/documents/articles.
  def self.all
    articles_path = begin
      str = if Rails.env.test?
        TEST_ARTICLES_PATH
      else
        ARTICLES_PATH
      end

      str += "/*.md"
    end

    Dir[articles_path].reduce([]) do |articles, file_path| 
      unless file_path == articles_path
        file_name = File.basename(file_path).gsub('.md', '')
        articles << Article.new(file_name)
      end
    end
  end

private
  def yaml_front_matter
    HashWithIndifferentAccess.new \
      YAML::load(raw_source.split("---\n")[1])
  end
end
