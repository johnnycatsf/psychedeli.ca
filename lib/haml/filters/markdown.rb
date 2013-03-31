require 'redcarpet'
require 'active_copy'

module Haml::Filters::Redcarpet
  include Haml::Filters::Base

  def render(text)
    markdown = Redcarpet::Markdown.new ActiveCopy::Renderer
    markdown.render text
  end
end
