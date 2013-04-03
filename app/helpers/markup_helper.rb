module MarkupHelper
  # Renders default HTML5 boilerplate +<meta>+ tags as well as custom
  # ones defined in the YAML, then it renders the CSRF meta tags
  # provided by Rails.
  def meta_tags
    render 'meta_tags'
  end

  # A helper method for prefetching static content, such as images
  # or other media, that we use often.
  def prefetch_content at_location
    tag :link, rel: 'prefetch', href: at_location
  end

  def custom_meta_tags
    Psychedelica::Application.config.metadata.reduce("") { |tags,(type,body)|
      tags += "#{tag :meta, name: type, content: body.html_safe}\n"
    }.html_safe
  end
end
