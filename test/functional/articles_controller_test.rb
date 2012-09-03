require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  setup { @controller = ArticlesController.new }

  context "GET /" do
    test "renders snippets of all articles" do
      get :index

      assert 200, response.status
    end
  end

  context "GET /gbs/2000/01/01/happy-new-year/" do
    setup { @page = "/gbs/2000/01/01/happy-new-year" }

    test "finds filename by given id parameter" do
      filename = @controller.send :with_filename_by, @page

      assert_equal "2000-01-01-happy-new-year", filename
    end

    test "render the page given by the id" do
      get :show, id: @page

      assert_equal 200, response.status
      assert_select '#post'
      assert_select 'h1', "happy new year"
    end

    test "render a 404 error when it can't find the post" do
      get :show, id: "/gbs/2012/01/01/the-final-countdown"

      assert_equal 404, response.status
      assert_select 'p', "The file you requested was not found."
    end
  end
end
