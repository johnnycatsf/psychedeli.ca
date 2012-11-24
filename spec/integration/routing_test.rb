require 'test_helper'

class RoutingTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.new "2000-01-01-happy-new-year"
  end

  it "an article can be viewed by id" do
    get "/articles/#{@article.id}"

    @response.status.should == 200
    assigns(:article).title.should == @article.title
  end

  it "an article can be viewed with a vanity url" do
    get "/2000/01/01/happy-new-year"

    @response.status.should == 200
    assigns(:article).title.should == @article.title
  end
end
