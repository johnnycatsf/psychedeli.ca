module ActiveCopy
  module ViewHelper
    # Render a given relative content path to Markdown.
    def render_copy from_source_path
      source_path = "#{Rails.root}/app/views/#{from_source_path}.md"
      if File.exists? source_path
        source = IO.read source_path
        template = Markdown.new
        template.render source
      else
        raise ArgumentError.new "#{source_path} does not exist."
      end
    end
  end
end
