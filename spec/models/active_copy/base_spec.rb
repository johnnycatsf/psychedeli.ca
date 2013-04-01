require 'spec_helper'

module ActiveCopy
  describe Base do
    let(:page) { BasicPage.new "About Us" }

    test "find the page by its id" do
      assert page.present?, "Page was not found"
    end

    test "find the right folder to read source files from" do
      page.collection_path.should == "test/fixtures/basic_pages/content"
    end

    test "read the yaml front matter as a hash" do
      page.title.should == "About Us"
    end

    test "read the article body" do
      page.source.should =~ /We are a very serious company/
    end

    test "return the correct partial path" do
      page.to_partial_path.should == "basic_pages/basic_page"
    end
  end
end
