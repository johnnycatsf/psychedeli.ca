# Represents a single article in the blog.
class Article < ActiveCopy::Base
  attr_accessible :layout, :title, :category, :date, :tags, :hn_item_id, :published

  deploy_to "public/:date_path/index.html"

  def date_path
    "#{date.year}/#{date.month}/#{date.day}"
  end
end
