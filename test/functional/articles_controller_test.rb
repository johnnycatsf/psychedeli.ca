require 'test_helper'

class ArticlesControllertest < ActionController::TestCase
  setup { @controller = ArticlesController.new }

  context "ArticlesController: GET /" do
    test "renders snippets of all articles" do
      get :index

      assert 200, response.status
    end
  end

  context "ArticlesController: GET /gbs/2000/01/01/happy-new-year/" do
    setup { @page = "2000-01-01-happy-new-year" }

    test "render the page given by the id" do
      get :show, id: @page

      assert_equal @page, assigns(:with_id)
      assert_equal 200, response.status
      assert_select 'article.standalone'
      assert_select 'h1', "happy new year!"
      assert_select 'strong', "wild"
    end

    test "render the page given by the date url" do
      get :show, year: '2000', month: '01', day: '01', title: 'happy-new-year'

      assert_equal @page, assigns(:with_id)
      assert_equal 200, response.status
      assert_select 'article.standalone'
      assert_select 'h1', "happy new year!"
      assert_select 'strong', "wild"
    end

    test "render a 404 error when it can't find the post" do
      get :show, id: "2012-01-01-the-final-countdown"

      assert_equal 404, response.status
      assert_select 'p', "The file you requested was not found."
    end
  end
end