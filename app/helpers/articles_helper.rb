# Includes the ActiveCopy helpers into the general application, and
# also includes a small method for retrieving articles in the global
# scope.
module ArticlesHelper
  include ActiveCopy::ViewHelper

  def articles
    @articles ||= Article.latest

    ArticleDecorator.decorate_collection @articles
  end
end
