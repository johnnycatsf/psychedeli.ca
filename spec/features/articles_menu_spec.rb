describe "Article titles in the sidebar menu" do
  before { visit '/' }

  it "loads just the article content when requested with JS", js: true do
    click_link 'new beginning'

    response.should be_success
    response.should have_content 'article'
    response.should_not have_content 'body'
  end

  it "loads the full page when requested directly" do
    click_link 'new beginning'

    response.should be_success
    response.should have_content 'article'
    response.should_not have_content 'html'
  end
end
