class ArticleDecorator < Draper::Base
  decorates :article

  allows :title, :category, :date, :tags

  def discuss_on_hacker_news
    if article.on_hacker_news?
      h.link_to "Discuss on Hacker News", hacker_news_url
    end
  end

  def date
    h.content_tag :time, article.date.strftime('%m/%d/%y'), timestamp: article.date.to_ms
  end

private
  def hacker_news_url
    "http://news.ycombinator.com?item=#{article.hn_item_id}"
  end
end
