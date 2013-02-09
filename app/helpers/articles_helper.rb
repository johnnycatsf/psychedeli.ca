module ArticlesHelper
  include ActiveCopy::ViewHelper

  def link_to_read_more article
    link_to "...", article.url
  end

  def show_menu?
    @show_menu || false
  end
end
