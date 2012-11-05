require 'active_support/core_ext/object/blank'
require 'action_view'

module ActiveCopy
  class Renderer < ActionView::PartialRenderer
    def render context, options, block
      binding.pry
    end
  end
end
