module ApplicationHelper
  # Return a +<title>+ tag for every page, basing it on the in-memory
  # +:title+ store, as well as the +page.title+ from Jekyll.
  def title_tag
    part = if page.title.present?
             page.title
           else
             content_for :title
           end

    text = if part.present?
             "#{part} | psychedeli.ca"
           else
             "psychedeli.ca | tubbo's random musings"
           end

    content_tag :title, text
  end

  # Set the title of the page either cosmetically or simply in the
  # titlebar.
  def title new_text, options={}
    content_for :title, new_text unless options[:cosmetic]
    content_tag :h1, new_text unless options[:hidden]
  end

  # Return the very long URL for Twitter's @Anywhere JavaScript file.
  def twitter_anywhere
    'http://platform.twitter.com/anywhere.js?id=zDPeS1kInJZv5AigGRT1Dg&amp;v=1'
  end

  # View-layer cache of RSS options in the +<a>+ tag for the feed.
  def rss_options
    @rss_opts ||= {
      rel: "alternate",
      title: "Subscribe to psychedeli.ca",
      type: "application/rss+xml"
    }
  end

  # Renders default HTML5 boilerplate +<meta>+ tags as well as custom
  # ones defined in the YAML.
  def html5_meta_tags
    content_tag :meta, charset: "utf-8"
    content_tag :meta, "http-equiv" => "X-UA-Compatible", :content => "IE=edge,chrome=1"
    content_tag :meta, name: "viewport", content: "width=device-width, initial-scale=1, maximum-scale=1"

    Psychedelica::Application.config.metadata.each do |type,body|
      content_tag :meta, name: type, content: body
    end
  end
end
