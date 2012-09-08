require 'test_helper'

class ActiveCopy::CompiledPageTest < ActiveSupport::TestCase
  setup do
    @article = Article.new "2000-01-01-happy-new-year"
    @compiled_page = ActiveCopy::CompiledPage.new @article
  end

  test "find haml template layout source" do
    assert_match "%article{ id: page.id }", @compiled_page.layout
  end

  test "article content can't be empty" do
    refute_empty @article.content
    refute_empty @compiled_page.article.content
  end

  test "render haml layout and markdown article to a compiled page" do
    assert_match "<article id=\"#{@article.id}\">", @compiled_page.html
  end

  test "saves the compiled page to the proper file path" do
    assert @compiled_page.save, "Compiled page did not save to #{@article.index_path}"
  end
end
