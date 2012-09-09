require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  setup { @article = Article.find "2000-01-01-happy-new-year" }

  test "find an article by its id" do
    assert @article.present?, "Article was not found"
  end

  test "read the yaml front matter as a hash" do
    assert_equal "happy new year!", @article.attributes[:title]
    assert_equal "happy new year!", @article.title
  end

  test "read the article body" do
    body = "\nIt's gonna be a **wild** party.\n\nHell yeah.\n"
    assert_match body, @article.source
  end
end
