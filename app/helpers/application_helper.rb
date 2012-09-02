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
end
