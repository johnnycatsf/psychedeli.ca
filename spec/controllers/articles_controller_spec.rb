require 'spec_helper'

describe ArticlesController do
  let(:article) { Article.find "2000-01-01-happy-new-year" }

  it "renders snippets of all articles" do
    get :index

    response.should be_success
    assigns(:articles).map(&:id).should include(article.id)
    response.should render_template('articles/index')
  end

  it "renders all articles in a category" do
    get :index, category: 'gbs'

    response.should be_success
    assigns(:articles).map(&:id).should include(article.id)
    response.should render_template('articles/index')
  end

  it "renders articles tagged with the given param" do
    get :index, tag: 'y2k'

    response.should be_success
    assigns(:articles).map(&:id).should include(article.id)
    response.should render_template('articles/index')
  end

  it "renders a missing items page when a bad category is requested" do
    get :index, category: 'foo'

    response.should be_success
    assigns(:articles).should be_empty
    response.should render_template('articles/empty')
  end

  it "renders a missing items page when a bad tag is requested" do
    get :index, category: 'bar'

    response.should be_success
    assigns(:articles).should be_empty
    response.should render_template('articles/empty')
  end

  it "renders a single article" do
    get :show, id: article.id

    response.should be_success
    assigns(:article).id.should == article.id
    response.should render_template('articles/show')
  end

  it "returns 404 when the article is not present" do
    get :show, id: 'foo'

    response.should be_missing
    response.should render_template('errors/not_found')
  end
end
