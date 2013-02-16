class ArticleDecorator < Draper::Decorator
  decorates :article
  delegate :id, :title, :category, :date, :tags, :path

  def discuss_on_hacker_news
    if source.on_hacker_news?
      h.link_to "Discuss on Hacker News", hacker_news_url, class: 'hacker-news'
    end
  end

  def posted_in_category_on_date
    h.content_tag :p, "Posted in #{category} on #{date}.".html_safe
  end

  def category
    h.content_tag :span, source.category, class: 'category'
  end

  def date
    #date_string = source.date.strftime('%m/%d/%y')
    h.time_tag source.date
  end

  def tags
    h.content_tag :span, "<strong>Tags:</strong> #{source.tags}".html_safe if source.has_tags?
  end

  def comments
    h.link_to "Comments", "#comments", rel: 'modal', class: 'comments'
  end

  def description
    h.render_copy "articles/content/#{source.id}"
  end

  def published_on
    source.date.to_s(:rfc822)
  end

  def url
    if Rails.env.production?
      "http://psychedeli.ca" + path
    else
      "http://#{Rails.env}.psychedeli.ca" + path
    end
  end

private
  def hacker_news_url
    "http://news.ycombinator.com?item=#{source.hn_item_id}"
  end
end
