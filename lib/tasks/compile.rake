namespace :compile do
  desc "Prepare for compilation by clobbering the public/ directory."
  task :prepare do
    system 'rm -rf public/*'
    puts "All files under public/ have been deleted."
  end

  desc "Copy extra files from app/views/jekyll to public/"
  task :static_files => :environment do
    Dir["#{Rails.root}/app/views/static/*"].each do |file_path|
      file_name = File.basename(file_path)
      system "cp #{file_path} public/#{file_name}"
    end
  end

  desc "Clobber and rebuild the public/ directory with Jekyll"
  task :articles => :environment do
    system 'bundle exec jekyll --config=config/jekyll.yml'
  end
end

task :compile => ["compile:prepare", "compile:articles", "compile:static_files"]
