module ArticlesHelper
  def link_to_read_more article
    link_to "...", article.url
  end

  def markdownify source
    markdown = ActiveCopy::Markdown.new
    markdown.render source
  end
end
