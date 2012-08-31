class Article
  include ActiveModel::Naming
  include ActiveModel::Validations
  include ActiveModel::Serialization

  attr_accessor :category, :content, :date, :published, :source, :tags, :title
  attr_reader :attributes

  def initialize with_file_path
    if File.exists? with_file_path
      @source = IO.read with_file_path
      @attributes = yaml_front_matter
      @attributes.each {|k,v| send :"#{k}=", v }
    else
      raise ArgumentError.new "File not found: #{with_file_path}"
    end
  end

private
  def yaml_front_matter
    start_parsing, end_parsing = false
    front_matter = @source.split("\n").reduce("") do |all, line|
      all += "#{line}\n" if start_parsing and not end_parsing
    end
  end
end
