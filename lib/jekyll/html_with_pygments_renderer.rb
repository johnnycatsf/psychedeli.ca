# The Markdown renderer that incorporates Pygments syntax highlighting.

require 'bundler'
Bundler.require :content

class HTMLwithPygments < Redcarpet::Render::HTML
  def block_code(code, language)
    #sha = Digest::SHA1.hexdigest(code)
    #Rails.cache.fetch ["code", language, sha].join('-') do
      Pygments.highlight(code, lexer: language)
    #end
  end
end
