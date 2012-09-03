# Represents a single article in the blog.
class Article < ActiveCopy::Base
  attr_accessible :layout, :title, :category, :date, :tags, :hn_item_id, :published

  # Tests whether this Article was (knowingly) posted to Hacker News.
  def on_hacker_news?
    hn_item_id.present?
  end
end
