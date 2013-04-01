require 'spec_helper'

describe ArticlesController do
  context "index" do
    it "renders snippets of all articles"
    it "renders snippets of articles in a category"
    it "renders snippets of articles with a tag"
  end

  context "show" do
    it "renders a single article"
    it "returns 404 when the article is not present"
  end
end
