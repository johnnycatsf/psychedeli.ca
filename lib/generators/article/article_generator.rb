# Generate an Article with ActiveCopy.
class ArticleGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  class_option :category,  aliases: '-c',
                              desc: 'Category that this article is filed under',
                           default: 'gbs'

  class_option :tags,      aliases: '-t',
                              desc: 'Tags to organize this article with.',
                           default: ''

  def do_it_to_it
    template "article.md.erb", "#{Rails.root}/app/views/articles/content/#{id}.md"
  end

private
  def id
    @article_id ||= "#{date}-#{file_name}"
  end

  def date
    @date_string ||= Time.now.strftime '%Y-%m-%d'
  end

  def title
    @title ||= file_name.titleize.downcase
  end

  def file_name
    human_name.parameterize
  end

  %w(category tags).each do |name|
    define_method name do
      options[name.to_sym]
    end
  end
end
