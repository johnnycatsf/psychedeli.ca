module NavigationHelper
  # Social networking buttons.
  def button_for network, account, options={}
    profile = "http://#{network}.com/#{account}"
    options.merge! class: 'social' unless options[:class] =~ /rss/

    content_tag(:li) do
      social_link_to logo_for(network), profile, options
    end
  end

  def social_link_to image, profile, options={}
    options.merge! class: "#{options[:class]} button".strip

    link_to image, profile, options
  end

  def rss_button options={}
    options.merge! rss_options.merge(class: 'rss')
    button_for 'rss', rss_feed_path, options.merge(rss_options)
  end

  def feedburner_link_tag
    tag :link, \
      rel: 'alternate',
      type: 'application/rss+xml',
      title: 'psychedeli.ca',
      href: rss_feed_path
  end

private
  def logo_for network_name
    image_tag "social/#{network_name}.png"
  end

  def rss_feed_path
    'http://feeds.feedburner.com/psychedelica-berserk'
  end

  # View-layer cache of RSS options in the +<a>+ tag for the feed.
  def rss_options
    {
      rel: "alternate",
      type: "application/rss+xml"
    }
  end
end
