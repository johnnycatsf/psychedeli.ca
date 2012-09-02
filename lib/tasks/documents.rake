require 'active_copy'

namespace :documents do
  include ActiveCopy::TasksHelper

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

  namespace :precompile do
    desc "Compile all content from its Markdown sources"
    task :all => :environment do
      compiled = 0
      total = 0

      ActiveCopy.models.each do |model|
        model.all.each do |document_model| 
          document_model.compile!
          compiled += 1 if document_model.compiled?
          total += 1
        end

        if ENV['VERBOSE']
          puts "Compiled #{compiled}/#{total} #{model.model_name.pluralize}."
        end
      end
    end

    ActiveCopy.models.each do |model|
      desc "Compile all #{model.model_name} content from its Markdown sources"
      task model.to_sym => :environment do
        compiled = 0
        total = 0

        model.all.each do |document_model| 
          document_model.compile!
          compiled += 1 if document_model.compiled?
          total += 1
        end

        if ENV['VERBOSE']
          puts "Compiled #{compiled}/#{total} #{model.model_name.pluralize}."
        end
      end
    end
  end

  task :precompile => ['precompile:all']
end

desc "Refresh the public/ directory with new Articles"
task :documents => ['documents:clean', 'documents:precompile:all']
