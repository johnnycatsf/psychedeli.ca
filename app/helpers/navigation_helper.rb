module NavigationHelper
  # Social networking buttons.
  def button_for network, account, options={}
    options = account if network == :rss
    style = 'social'
    profile = if network == :rss
      style = 'rss'
      feedburner_path
    else
      "http://#{network}.com/#{account}"
    end

    content_tag(:li) do
      social_link_to logo_for(network), profile, options.merge(class: style)
    end
  end

  def social_link_to image, profile, options={}
    options.merge! class: "#{options[:class]} button".strip

    link_to image, profile, options
  end

  def feedburner_link_tag
    tag :link, \
      rel: 'alternate',
      type: 'application/rss+xml',
      title: 'psychedeli.ca',
      href: feedburner_path
  end

private
  def logo_for network_name
    image_tag "social/#{network_name}.png"
  end

  def feedburner_path
    "http://feeds.feedburner.com/psychedelica-berserk"
  end
end
