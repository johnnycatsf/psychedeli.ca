require 'fileutils'; include FileUtils

namespace :articles do
  desc "Clean the public/ folder of all generated Articles"
  task :clean => :environment do
    folder = "#{Rails.root}/public"
    Dir[folder].each { |path| rm_rf path if destroyable? path }
  end

  desc "Compile Article content from their Markdown sources"
  task :precompile => :environment do
    compiler = ArticleCompiler.new

    puts "Compiling #{Article.all.count} articles."

    Article.all.each do |article|
      html = compiler.render article
      if article.path.is_a? String
        mkdir_p article.path 
        File.new("#{article.path}/index.html") { |f| f.puts html }
      else
        puts "Error compiling article: #{article.inspect}"
      end
    end
  end
end

def destroyable? file_path
  file_path != "#{Rails.root}/public" or
  File.directory? file_path or
  file_path =~ /index\.html|comments\.html/
end

desc "Refresh the public/ directory with new Articles"
task :articles => ['articles:clean', 'articles:precompile']

desc "Legacy: Compile all Jekyll articles"
task :compile => ['articles']
