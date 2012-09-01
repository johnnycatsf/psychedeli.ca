require 'fileutils'; include FileUtils

namespace :articles do
  desc "Clean the public/ folder of all generated Articles"
  task :clean => :environment do
    folder = "#{Rails.root}/public"

    # Articles and stuff.
    Dir[folder].each do |path|
      system "rm -rf #{path}" if File.directory? path
    end

    # Special top-level HTML files.
    %w(index.html comments.html).each do |special_file|
      rm_rf "#{folder}/#{special_file}"
    end
  end

  desc "Compile Article content from their Markdown sources"
  task :precompile => :environment do
    compiler = ArticleCompiler.new

    puts "Compiling #{Article.all.count} articles."

    Article.all.each do |article|
      html = compiler.render article
      mkdir_p article.path
      File.new("#{article.path}/index.html") { |f| f.puts html }
    end
  end
end

def can_be_destroyed? file_path
  file_path != "#{Rails.root}/public" or
  File.directory? file_path or
  file_path =~ /index\.html|comments\.html/
end

desc "Refresh the public/ directory with new Articles"
task :articles => ['articles:clean', 'articles:precompile']

desc "Legacy: Compile all Jekyll articles"
task :compile => ['articles']
