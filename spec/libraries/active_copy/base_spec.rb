require 'test_helper'

# A mock for us to play with
class BasicPage < ActiveCopy::Base
  attr_accessible :title
end

describe "ActiveCopy::Base", ActiveSupport::TestCase do
  setup { @page = BasicPage.new "about" }

  it "find the page by its id" do
    @page.present?, "Page was not found".should.not == nil
  end

  it "find the right folder to read source files from" do
    @page.collection_path.should == "test/fixtures/basic_pages/content"
  end

  it "read the yaml front matter as a hash" do
    @page.title.should == "About Us"
  end

  it "read the article body" do
    assert_match "We are a very serious company.", @page.source
  end

  it "return the correct partial path" do
    @page.to_partial_path.should == "basic_pages/basic_page"
  end
end
