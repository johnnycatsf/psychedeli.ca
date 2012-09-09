require 'test_helper'

class ArticlesHelperTest < ActionView::TestCase
  include ArticlesHelper

  test "prepare html from markdown" do
    source = "**test**"
    assert_equal "<p><strong>test</strong></p>\n", markdownify(source)
  end
end
