# Represents a single article in the blog.
class Article < ActiveDocument::Base
  attr_accessible :layout, :title, :category, :date, :tags, :hn_item_id, :published

  deploy_to "#{public_path}/#{date.year}/#{date.month}/#{date.day}/index.html"
end
