require 'spec_helper'

module ActiveCopy
  # A mock for us to play with
  class BasicPage < ActiveCopy::Base
    attr_accessible :title
  end

  # The actual tests
  describe Base do
    subject { BasicPage.new "about" }

    it "find the page by its id" do
      subject.should be_present, "Page was not found"
    end

    it "find the right folder to read source files from" do
      subject.collection_path.should == "spec/fixtures/active_copy/basic_pages/content"
    end

    it "read the yaml front matter as a hash" do
      subject.title.should == "About Us"
    end

    it "read the article body" do
      subject.source.should =~ /We are a very serious company/
    end

    it "return the correct partial path" do
      subject.to_partial_path.should == "active_copy/basic_pages/basic_page"
    end
  end
end
