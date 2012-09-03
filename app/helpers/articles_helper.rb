module ArticlesHelper
  def link_to_read_more article
    link_to "...", article.url
  end
end
