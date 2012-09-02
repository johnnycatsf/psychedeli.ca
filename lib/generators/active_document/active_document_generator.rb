class ActiveDocumentGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def generate_ruby
    copy_template "model.rb", "app/models/#{file_name}.rb"
    copy_template "test.rb", "test/unit/#{file_name}_test.rb"
  end

  def generate_markdown
    %w(app/documents test/fixtures/documents).each do |root_path|
      copy_template "example.md", "#{root_path}/article.md"
    end
  end
end
