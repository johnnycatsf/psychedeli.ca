xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "psychedeli.ca"
    xml.description "tubbo's blog about music, hacking and fresh fruit."
    xml.link root_url

    articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description article.description
        xml.pubDate article.published_on
        xml.link article.url
        xml.guid article.path
      end
    end
  end
end
