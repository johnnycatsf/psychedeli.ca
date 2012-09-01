namespace :test do
  desc "Test compilation of the Jekyll static site. Fail the build if it doesn't compile."
  task :compilation => :environment do
    if system "bundle exec jekyll --config=config/jekyll.yml"
      exit 0
    else
      puts "Jekyll site failed to compile."
      exit $?
    end
  end

  namespace :prepare do
    desc "Prepare configuration for the test environment on CI."
    task :configuration => :environment do
      unless File.exists? "#{Rails.root}/config/status_exchange.yml"
        cp "#{Rails.root}/config/status_exchange.yml.example", "#{Rails.root}/config/status_exchange.yml"
      end
    end
  end
end

task :test => ['test:prepare:configuration', 'test:run', 'test:compilation'] 
