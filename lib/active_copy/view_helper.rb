module ActiveCopy
  module ViewHelper
    # Render a given relative content path to Markdown.
    def render_copy for_given_path
      if File.exists? source_path(for_given_path)
        raw_source = IO.read source_path(for_given_path)
        source = raw_source.split("---\n")[2]
        template = ActiveCopy::Markdown.new
        require 'pry'; binding.pry
        template.render(source).html_safe
      else
        raise ArgumentError.new "#{for_given_path} does not exist."
      end
    end

  private
    def source_path for_file_path
      @source_path ||= if Rails.env.test?
        "#{Rails.root}/spec/fixtures/#{for_file_path}.md"
      else
        "#{Rails.root}/app/views/#{for_file_path}.md"
      end
    end
  end
end
