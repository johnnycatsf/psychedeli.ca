class ArticleDecorator < Draper::Base
  decorates :article

  allows :title, :category, :date, :tags

  def discuss_on_hacker_news
    if article.on_hacker_news?
      h.link_to "Discuss on Hacker News", hacker_news_url, class: 'hacker-news'
    end
  end

  def posted_in_category_on_date
    h.content_tag :p, "Posted in #{category} on #{date}.".html_safe
  end

  def category
    h.content_tag :span, article.category, class: 'category'
  end

  def date
    #date_string = article.date.strftime('%m/%d/%y')
    h.time_tag article.date
  end

  def tags
    h.content_tag :span, "<strong>Tags:</strong> #{article.tags}".html_safe if article.has_tags?
  end

  def comments
    h.link_to "Comments", "#comments", rel: 'modal', class: 'comments'
  end

  def description
    article.source
  end

  def published_on
    article.date.to_s(:rfc822)
    #Date.new(article.date).to_s(:rfc822)
  end

  def url
    if Rails.env.production? or Rails.env.stage?
      "http://psychedeli.ca#{article.path}"
    else
      article.path
    end
  end

private
  def hacker_news_url
    "http://news.ycombinator.com?item=#{article.hn_item_id}"
  end
end
