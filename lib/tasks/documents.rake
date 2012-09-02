require 'active_document/tasks_helper'

namespace :documents do
  include ActiveDocument::TasksHelper

  desc "Clean the public/ folder of all generated content"
  task :clean => :environment do
    folder = "#{Rails.root}/public"
    paths_removed = 0
    msg = ""

    if File.exists? folder and File.directory? folder
      Dir["#{folder}/*/"].each do |path| 
        unless path.blank? or path.nil?
          rm_rf path
          msg = "Removed #{path}"
          paths_removed += 1
        end
      end

      msg = "Nothing needed to be removed" unless paths_removed > 0
    else
      msg = "public/ directory does not exist, skipping clean and remaking.."
      mkdir_p folder
    end

    puts msg if ENV['VERBOSE']
  end

  desc "Compile content from their Markdown sources"
  task :precompile => :environment do
    compiled_articles = 0
    total_articles = 0

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

desc "Refresh the public/ directory with new Articles"
task :documents => ['documents:clean', 'documents:precompile:all']
