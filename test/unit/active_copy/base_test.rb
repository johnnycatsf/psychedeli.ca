require 'test_helper'

# A mock for us to play with
class BasicPage < ActiveCopy::Base
  attr_accessible :title
end

class ActiveCopy::BaseTest < ActiveSupport::TestCase
  setup { @page = BasicPage.new "about" }

  test "find the page by its id" do
    assert @page.present?, "Page was not found"
  end

  test "read the yaml front matter as a hash" do
    assert_equal "About Us", @page.title
  end

  test "read the article body" do
    ssert_match "We are a very serious company.", @page.source
  end
end
