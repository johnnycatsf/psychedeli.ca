namespace :articles do
  desc "Clean the public/ folder of all generated Articles"
  task :clean => :environment do
    folder = "#{Rails.root}/public"

    # Articles and stuff.
    Dir[folder].each do |path|
      system "rm -rf #{path}" if File.is_dir?
    end

    # Special top-level HTML files.
    %w(index.html comments.html).each do |special_file|
      system "rm -rf #{folder}/#{special_file}"
    end
  end

  desc "Compile Article content from their Markdown sources"
  task :precompile => :environment do
    system 'bundle exec jekyll --config=config/jekyll.yml'
  end
end

desc "Refresh the public/ directory with new Articles"
task :articles => ['articles:clean', 'articles:precompile']

desc "Legacy: Compile all Jekyll articles"
task :compile => ['articles']
