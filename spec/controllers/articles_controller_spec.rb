require 'test_helper'

describe "ArticlesController", ActionController::TestCase do
  setup { @controller = ArticlesController.new }

  describe "ArticlesController: GET /" do
    it "renders snippets of all articles" do
      get :index

      200, response.status.should.not == nil
    end
  end

  describe "ArticlesController: GET /gbs/2000/01/01/happy-new-year/" do
    setup { @page = "2000-01-01-happy-new-year" }

    it "render the page given by the id" do
      get :show, id: @page

      assigns(:with_id).should == @page
      response.status.should == 200
      assert_select 'article.standalone'
      assert_select 'h1', "happy new year!"
      assert_select 'strong', "wild"
    end

    it "render the page given by the date url" do
      get :show, year: '2000', month: '01', day: '01', title: 'happy-new-year'

      assigns(:with_id).should == @page
      response.status.should == 200
      assert_select 'article.standalone'
      assert_select 'h1', "happy new year!"
      assert_select 'strong', "wild"
    end

    it "render a 404 error when it can't find the post" do
      get :show, id: "2012-01-01-the-final-countdown"

      response.status.should == 404
      assert_select 'p', "The file you requested was not found."
    end
  end
end
