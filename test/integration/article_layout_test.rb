require 'test_helper'

class ArticleLayoutTest < ActionDispatch::IntegrationTest
  test "articles accessed normally load the layout" do
    get '/2000/01/01/happy-new-year'

    assert_template partial: 'articles/_article', layout: 'layouts/application'
  end

  test "articles accessed by ajax do not load the layout" do
    xhr :get, '/2000/01/01/happy-new-year'

    assert_template partial: 'articles/_article', layout: false
  end
end
