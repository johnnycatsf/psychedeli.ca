# Base class for an +ActiveDocument+ model.
module ActiveDocument
  class Base
    extend ActiveModel::Naming
    include ActiveModel::Serialization

    attr_reader :attributes
    attr_accessor :accessible_attrs

    # Instantiate using the filename as an ID, set the YAML front matter
    # to a Hash called +attributes+, and define a reader method for each 
    # attribute that has a corresponding key in the +attr_accessible+
    # definition for this model.
    def initialize with_filename
      @id = with_filename
      @attributes = yaml_front_matter

      accessible_attrs.each do |attr| 
        define_method attr { @attributes[attr] }
      end
    end

    # Compile the template using ActionView to the public HTML file.
    def compile!
      ActiveDocument::Compiler.new(self).save
    end

    # Test if the +Article+ has been compiled by checking whether
    # +Article.path+ exists.
    def compiled?
      File.exists? path
    end

    # Return absolute path to public HTML file.
    def index_path
      "#{path}/index.html"
    end

    # Return absolute path to public cached copy.
    def path
      @public_path ||= if Rails.env.test?
                         "#{Rails.root}/tmp/site/#{relative_path}"
                       else
                         "#{Rails.root}/public/#{relative_path}"
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
      @source_path ||= File.join collection_path, "#{id}.md"
    end

    # Test if the source file is present on this machine.
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

    # Read all files from the +collection_path+, then instantiate them
    # as members of this model. Return as an +Array+.
    def self.all
      Dir["#{collection_path}/*.md"].reduce([]) do |articles, md_path| 
        unless md_path == collection_path
          file_name = File.basename(md_path).gsub('.md', '')
          articles << self.new(file_name)
        end
      end
    end

    # Reuse attr_accessible for defining which attributes can be set in
    # the YAML front matter. This also creates accessors for each named
    # attribute (so you don't have to do it in the model class), which
    # allows for YAML front matter attributes to be accessed just like
    # normal model properties.
    def self.attr_accessible *attrs
      self.accessible_attrs = attrs.reduce([]) do |attrs,attribute|
        attrs << attribute
      end
    end

  private
    def yaml_front_matter
      HashWithIndifferentAccess.new \
        YAML::load(raw_source.split("---\n")[1])
    end

    def self.collection_path
      @collection_path ||= if Rails.env.test?
        "#{Rails.root}/app/documents/#{self.model_name.parameterize}"
      else
        "#{Rails.root}/test/fixtures/#{self.model_name.parameterize}"
      end
    end
  end
end
