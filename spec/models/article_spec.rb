require 'spec_helper'

describe Article do
  subject { Article.find "2000-01-01-happy-new-year" }

  it "can be found by id" do
    subject.should be_present
  end

  it "parses out yaml front matter into a hash" do
    subject.attributes.should be_a Hash
    subject.attributes.keys.should include('title')
  end

  it "outputs hash values as attribute methods" do
    subject.title.should == "happy new year!"
  end

  it "has the correct article body" do
    subject.source.should =~ /Hell yeah/
  end

  it "computes the path from the date and title" do
    subject.path.should == "/2000/01/01/happy-new-year"
  end

  it "defaults to being published" do
    subject.should be_published
  end

  context "when being searched" do
    let(:unpublished) { Article.find "2000-01-02-cant-see-me" }

    it "returns all articles" do
      Article.all.should_not be_empty
      Article.all.map(&:id).should include(subject.id)
    end

    it "only returns published articles in collection" do
      unpublished.should_not be_published
      Article.published.map(&:id).should_not include(unpublished.id)
    end

    it "sorts published articles by created_at" do
      Article.latest.map(&:id).should include(subject.id)
      Article.latest.map(&:id).should_not include(unpublished.id)
    end
  end
end
