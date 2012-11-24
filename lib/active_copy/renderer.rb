require 'pygments'
require 'redcarpet'

module ActiveCopy
  class Renderer < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight code, lexer: language
    end
  end
end
