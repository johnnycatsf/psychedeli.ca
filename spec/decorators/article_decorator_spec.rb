require 'spec_helper'

describe ArticleDecorator do
  subject { ArticleDecorator.decorate Article.find("2000-01-01-happy-new-year") }

  it "links to the category" do
    link_to_cat = "<a class=\"category\" href=\"/category/#{subject.category}\">#{subject.category}</a>"

    subject.category_link.should == link_to_cat
  end

  context "markdown content" do
    it "renders to escaped html for web browsers" do
      subject.content.should_not be_empty
    end

    it "renders to unescaped html for rss feeds" do
      subject.description.should == subject.content
    end

    it "can be truncated after the first paragraph" do
      text = subject.content.split('<p>').second
      subject.truncated_content.should == "<p>#{text}</p>"
    end
  end

  context "date" do
    it "is rendered as a time_tag" do
      subject.date =~ /\A<time/
    end

    it "formats to rfc822" do
      subject.published_on.should == '1 Jan 2000'
    end
  end

  context "each article tag" do
    it "is grouped in a div" do
      subject.tag_links.should =~ /\A<div/
    end

    it "is linked to the search path" do
      subject.annotated_tags.should =~ /\A<a href/
    end
  end

  it "computes its own path" do
    full_path = "http://localhost:3000" + subject.path

    subject.url.should == full_path
  end
end
