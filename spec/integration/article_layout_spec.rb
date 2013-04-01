require 'spec_helper'

describe "Article layouts" do
  it "are shown when accessed normally" do
    get '/2000/01/01/happy-new-year'

    assert_template partial: 'articles/_article', layout: 'layouts/application'
  end

  it "are not loaded when accessed with xml_http_request" do
    xhr :get, '/2000/01/01/happy-new-year'

    assert_template partial: 'articles/_article', layout: false
  end
end
