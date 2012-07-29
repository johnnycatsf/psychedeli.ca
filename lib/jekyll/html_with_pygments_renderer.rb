require 'bundler'
Bundler.require :content

# A Markdown renderer that incorporates Pygments syntax highlighting.
class HTMLwithPygments < Redcarpet::Render::HTML
  def block_code(code, language)
    Pygments.highlight(code, :lexer => language)
  end
end
