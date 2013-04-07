# A single article in the blog.
class Article < ActiveCopy::Base
  attr_accessible :layout, :title, :category, :date, :tags, :hn_item_id, :published
  include Draper::Decoratable

  # Sort published Articles by date, ascending.
  def self.latest
    published.sort { |prev_article, next_article|
      next_article.date <=> prev_article.date
    }
  end

  def self.published
    all.select { |article| article.present? && article.published? }
  end

  # Returns whether this article is `published`. If no property called
  # published is defined in the Front Matter, this just defaults to
  # +true+.
  def published?
    return true if published.nil?
    published
  end

  # Test whether this Article was (knowingly) posted to Hacker News.
  def on_hacker_news?
    hn_item_id.present?
  end

  # Test whether this Article includes any tags.
  def has_tags?
    tags.present?
  end

  # Find the file path of this Article.
  def path
    @path ||= begin
      arr = self.id.split('-')
      date = arr[0..2].join('/')
      title = arr[3..-1].join('-')

      "/#{date}/#{title}"
    end
  end
end
