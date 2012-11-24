require 'spec_helper'

describe "Article layout" do
  it "displays when accessed with a normal HTTP request" do
    get '/2000/01/01/happy-new-year'

    assert_template partial: 'articles/_article', layout: 'layouts/application'
  end

  it "does not display when accessed using XmlHttpRequest" do
    xhr :get, '/2000/01/01/happy-new-year'

    assert_template partial: 'articles/_article', layout: false
  end
end
