class DocumentGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  hook_for :test_framework, as: :model, fixtures: false

  def generate_files
    template "model.rb.erb", "app/models/#{file_name}.rb"

    %w(app/documents test/fixtures/documents).each do |root_path|
      copy_file "example.md", "#{root_path}/#{plural_table_name}/example.md"
    end
  end
end
