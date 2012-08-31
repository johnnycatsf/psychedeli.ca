require 'fileutils'; include FileUtils

namespace :articles do
  desc "Clean the public/ folder of all generated Articles"
  task :clean => :environment do
    folder = "#{Rails.root}/public"

    # Articles and stuff.
    Dir[folder].each do |path|
      rm_rf path if File.is_dir? path
    end

    # Special top-level HTML files.
    %w(index.html comments.html).each do |special_file|
      rm_rf "#{folder}/#{special_file}"
    end
  end

  desc "Compile Article content from their Markdown sources"
  task :precompile => :environment do
    compiler = ArticleCompiler.new

    Article.all.each do |article|
      html = compiler.render article
      path = "#{article.path}/#{article.id}"
      mkdir_p path
      File.new("#{path}/index.html") { |f| f.puts html }
    end
  end
end

desc "Refresh the public/ directory with new Articles"
task :articles => ['articles:clean', 'articles:precompile']

desc "Legacy: Compile all Jekyll articles"
task :compile => ['articles']
