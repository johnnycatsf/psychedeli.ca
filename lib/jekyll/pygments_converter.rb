require 'redcarpet'
require_relative '../html_with_pygments_renderer'

module Jekyll
  class PygmentsConverter < Converter
    safe true

    priority :low

    def matches(ext)
      ext =~ /md/i
    end 

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      renderer = HTMLwithPygments.new(hard_wrap: true, filter_html: true)

      options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true
      }

      Redcarpet::Markdown.new(renderer, options).render(content)
    end
  end
end
