require 'active_support/core_ext/object/blank'
require 'action_pack/action_view/abstract_renderer'

module ActionCopy
  class Renderer < ActionView::Renderer::PartialRenderer
  private
    def setup(context, options, block)
      @view   = context
      partial = options[:partial]

      @options = options
      @locals  = options[:locals] || {}
      @block   = block
      @details = extract_details(options)

      if String === partial
        @object     = options[:object]
        @path       = partial
        @collection = collection
      else
        @object = partial

        if @collection = collection_from_object || collection
          paths = @collection_data = @collection.map { |o| partial_path(o) }
          @path = paths.uniq.size == 1 ? paths.first : nil
        else
          @path = partial_path
        end
      end

      if @path
        @variable, @variable_counter = retrieve_variable(@path)
      else
        paths.map! { |path| retrieve_variable(path).unshift(path) }
      end

      if String === partial && @variable.to_s !~ /^[a-z][a-zA-Z0-9]*$/
        raise ArgumentError.new("The copy file (#{partial}) is not a valid Ruby identifier; " +
                                "make sure your copy file starts with a letter, " +
                                "and is followed by any combinations of letters, numbers, or underscores.")
      end

      extract_format(@path, @details)
      self
    end
  end
end
