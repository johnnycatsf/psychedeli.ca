module ApplicationHelper
  # Renders default HTML5 boilerplate +<meta>+ tags as well as custom
  # ones defined in the YAML, then it renders the CSRF meta tags
  # provided by Rails.
  def meta_tags
    content_tag :meta, charset: "utf-8"
    content_tag :meta, "http-equiv" => "X-UA-Compatible", :content => "IE=edge,chrome=1"
    content_tag :meta, name: "viewport", content: "width=device-width"

    Psychedelica::Application.config.metadata.each do |type,body|
      content_tag :meta, name: type, content: body
    end

    csrf_meta_tags
  end

  # A helper method for prefetching static content, such as images
  # or other media, that we use often.
  def prefetch_content at_location
    tag :link, rel: 'prefetch', href: at_location
  end
end
