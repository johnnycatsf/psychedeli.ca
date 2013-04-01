class ArticleDecorator < Draper::Decorator
  decorates :article
  delegate :id, :title, :category, :date, :tags, :path

  def discuss_on_hacker_news
    if source.on_hacker_news?
      h.link_to "Discuss on Hacker News", hacker_news_url, class: 'hacker-news'
    end
  end

  def category
    h.link_to source.category, h.category_path(source.category), class: 'category'
  end

  def content
    h.render_copy("articles/content/#{source.id}").html_safe
  end

  # For truncated viewings
  def truncated_content
    content.split("</p>").first
  end

  def date
    #date_string = source.date.strftime('%m/%d/%y')
    h.time_tag source.date
  end

  def tags
    h.content_tag :div, annotated_tags.html_safe, class: 'tags'
  end

  def annotated_tags
    return "" if source.tags.nil?

    source.tags.split(', ').map {
      |tag| h.link_to "##{tag}", h.tag_path(tag) 
    }.join(' ')
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
      "http://localhost:3000" + path
    end
  end

private
  def hacker_news_url
    "http://news.ycombinator.com?item=#{source.hn_item_id}"
  end
end
