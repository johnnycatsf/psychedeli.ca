require 'spec_helper'

describe Article do
  let(:body) { "\nIt's gonna be a **wild** party.\n\nHell yeah.\n" }
  subject { Article.find "2000-01-01-happy-new-year" }

  it "can be found by id" do
    @article.should be_present
  end

  it "reads the yaml front matter as a hash" do
    @article.attributes.should be_a Hash
    @article.attributes.keys.should include(:title)
  end

  it "outputs hash values as attribute methods" do
    @article.title.should == "happy new year!"
  end

  it "can read the article body" do
    @article.source.should =~ /#{body}/o
  end

  it "computes the path from the date and title" do
    @article.path.should == "/2000/01/01/happy-new-year"
  end
end
