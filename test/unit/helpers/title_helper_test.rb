require 'test_helper'

class TitleHelperTest < ActionView::TestCase
  include TitleHelper

  test "title tag shows content of :title" do
    skip
    assert content_for(:title, "test")

    assert_select :title, "test | psychedeli.ca", title_tag
  end

  test "page title can be set" do
    skip
    assert_equal "<h1>test</h1>", title('test')
  end

  test "page title can be set without printing it" do
    skip
    assert title('test', :hidden)
  end

  test "page title can be set cosmetically without updating the <title>" do
    skip
    assert_equal "<h1>test</h1>", title('test')
  end

  test "page title can be viewed as a <title>" do
    skip
    assert_equal "<h1>test</h1>", title('test')
    assert_equal "<title>test | psychedeli.ca", title_tag
  end
end
