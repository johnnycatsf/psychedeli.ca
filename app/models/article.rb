# A single article in the blog.
class Article < ActiveCopy::Base
  attr_accessible :layout, :title, :category, :date, :tags, :hn_item_id, :published

  # Tests whether this Article was (knowingly) posted to Hacker News.
  def on_hacker_news?
    hn_item_id.present?
  end

  def has_tags?
    tags.present?
  end

  # Sorts Articles by date, ascending.
  def self.latest
    all.reverse.select { |a| a.present? }.sort { |a1, a2| a1.date <=> a2.date }
  end

  def path
    @path ||= begin
      arr = self.id.split('-')
      date = arr[0..2].join('/')
      title = arr[3..-1].join('-')

      "/#{date}/#{title}"
    end
  end
end
