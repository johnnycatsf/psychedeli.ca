require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.new "2000-01-01-happy-new-year"
  end

  test "an article can be viewed by id" do
    get "/articles/#{@article.id}"

    assert_equal 200, @response.status
    assert_equal @article.title, assigns(:article).title
  end

  test "an article can be viewed with a vanity url" do
    get "/2000/01/01/happy-new-year"

    assert_equal 200, @response.status
    assert_equal @article.title, assigns(:article).title
  end
end
