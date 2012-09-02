class ActiveDocumentGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def generate_ruby
    copy_file "model.rb", "app/models/#{file_name}.rb"
    copy_file "test.rb", "test/unit/#{file_name}_test.rb"
  end

  def generate_markdown
    %w(app/documents test/fixtures/documents).each do |root_path|
      file_path = "#{root_path}/#{plural_table_name}/example.md"
      copy_file "example.md", file_path
    end
  end
end
