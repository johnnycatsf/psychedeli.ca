module NavigationHelper
  # Social networking buttons.
  def button_for network, account, options={}
    profile = "http://#{network}.com/#{account}"

    content_tag(:li) do
      social_link_to logo_for(network), profile, options
    end
  end

  def social_link_to image, profile, options={}
    options.merge! \
      class: "#{options.class} button has-tip",
      data: { tooltip: true, title: options[:title] }

    link_to image, profile, options
  end

  def rss_button options={}
    options.merge! rss_options
    button_for 'rss', rss_feed_path, options.merge(rss_options)
  end

private
  def logo_for network_name
    image_tag "social/#{network_name}.png"
  end
end
