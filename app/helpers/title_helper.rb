# Helper methods for assigning the page title, and applying it
# to the +<title>+ of each served HTML document.
module TitleHelper
  # Return a +<title>+ tag for every page, basing it on the in-memory
  # +:title+ store, as well as the +page.title+ from Jekyll.
  def title_tag
    part = content_for :title
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
end
