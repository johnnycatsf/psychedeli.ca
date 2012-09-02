require 'fileutils'; include FileUtils

namespace :articles do
  desc "Clean the public/ folder of all generated Articles"
  task :clean => :environment do
    folder = "#{Rails.root}/public"

    if File.exists? folder and File.directory? folder
      Dir["#{folder}/**"].each do |path| 
        if destroyable? path
          rm_rf path 
          msg = "Removed #{path}"
        else
          msg = "Left #{path} intact."
        end
      end
    else
      msg = "public/ directory does not exist, skipping clean and remaking.."
      mkdir_p folder
    end

    puts msg if ENV['VERBOSE']
  end

  desc "Compile Article content from their Markdown sources"
  task :precompile => :environment do
    compiled_articles = 0, total_articles = 0
    Article.all.each do |article| 
      article.compile!
      compiled_articles += 1 if article.compiled?
      total_articles += 1
    end

    if ENV['VERBOSE']
      puts "Compiled #{compiled_articles}/#{total_articles} articles."
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
