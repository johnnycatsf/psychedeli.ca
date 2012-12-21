require 'spec_helper'

describe Article do
  before { @article = Article.find "2000-01-01-happy-new-year" }

  it "find an article by its id" do
    @article.should be_present, "Article was not found"
  end

  it "read the yaml front matter as a hash" do
    @article.attributes[:title].should == "happy new year!"
    @article.title.should == "happy new year!"
  end

  it "read the article body" do
    body = "\nIt's gonna be a **wild** party.\n\nHell yeah.\n"
    assert_match body, @article.source
  end

  it "compute the path from the date and title" do
    @article.path.should == "/2000/01/01/happy-new-year"
  end
end
