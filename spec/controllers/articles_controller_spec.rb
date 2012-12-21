require 'spec_helper'

describe ArticlesController do
  before(:all) { @page = "2000-01-01-happy-new-year" }

  context "GET /" do
    it "renders the about page and a menu of all articles" do
      get :index

      response.should be_success
    end
  end

  context "GET /2000/01/01/happy-new-year/" do
    it "render the page given by the id" do
      get :show, id: @page

      assigns(:with_id).should == @page
      response.should be_success
      response.should render_template(layout: 'applicaton')
    end

    it "render the page given by the date url" do
      get :show, year: '2000', month: '01', day: '01', title: 'happy-new-year'

      assigns(:with_id).should == @page
      response.should be_success
    end

    it "render a 404 error when it can't find the post" do
      get :show, id: "2012-01-01-the-final-countdown"

      response.should be_missing
    end
  end

  context "GET /2000/01/01/happy-new-year/partial" do
    it "render the page given by the id" do
      xhr :get, :partial, id: @page, format: :html

      assigns(:by_id).should == @page
      response.should be_success
    end

    it "render the page given by the date url" do
      xhr :get, :partial, year: '2000', month: '01', day: '01', title: 'happy-new-year', format: :html

      assigns(:by_id).should == @page
      response.should be_success
    end

    it "render a 404 error when it can't find the post" do
      xhr :get, :partial, id: "2012-01-01-the-final-countdown", format: :html

      response.should be_missing
    end
  end

end
