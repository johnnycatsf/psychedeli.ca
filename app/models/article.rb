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

  attr_reader :title, :category, :date, :tags, :id, :hn_item_id

  ARTICLES_PATH = "#{Rails.root}/app/documents/articles"
  TEST_ARTICLES_PATH = "#{Rails.root}/test/fixtures/articles"

  # Instantiate using the filename as an ID.
  def initialize with_filename
    @id = with_filename
  end

  # Parse the YAML content between the first two occurrances of
  # "---" into a +HashWithIndifferentAccess+, which allow you to
  # access said attributes in Ruby.
  def attributes
    @attributes ||= HashWithIndifferentAccess.new \
      YAML::load(raw_source.split("---\n\n")[1])
  end

  # Return absolute path to public cached copy, or +false+ if it
  # doesn't exist.
  def path
    @public_path ||= "#{Rails.root}/public/#{category}/#{id}"

    if File.exists? @public_path
      @public_path
    else
      false
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
    @source ||= raw_source.gsub(/---\\n(.*)---\\n\\n/, '')
  end

  # A Hash representation of the YAML attributes in addition to the
  # Markdown-rendered content. This forms a complete attributes Hash
  # just like ActiveRecord models.
  def attributes
    @attributes ||= ActiveSupport::HashWithIndifferentAccess.new \
      YAML::load(raw_source.split("---\n")[1])
    @attributes.merge(content: content)
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
end
