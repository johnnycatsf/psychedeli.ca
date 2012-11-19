module ActiveCopy
  module ViewHelper
    # Render a given relative content path to Markdown.
    def render_copy from_source_path
      source_path = if Rails.env.test?
        "#{Rails.root}/test/fixtures/#{from_source_path}.md"
      else
        "#{Rails.root}/app/views/#{from_source_path}.md"
      end
      if File.exists? source_path
        raw_source = IO.read source_path
        source = raw_source.split("---\n")[2]
        template = ActiveCopy::Markdown.new
        template.render(source).html_safe
      else
        raise ArgumentError.new "#{source_path} does not exist."
      end
    end
  end
end
