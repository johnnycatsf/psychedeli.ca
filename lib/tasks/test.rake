namespace :test do
  desc "Compile the static site on CI if the rest of the tests pass."
  task :compilation => :environment do
    if system "bundle exec jekyll --config=config/jekyll.yml"
      exit 0
    else
      puts "Jekyll site failed to compile."
      exit $?
    end
  end

  namespace :prepare do
    desc "Copy the status_exchange.yml file from the example in Git. For CI and lazy devs."
    task :configuration => :environment do
      unless File.exists? "#{Rails.root}/config/status_exchange.yml"
        cp "#{Rails.root}/config/status_exchange.yml.example", "#{Rails.root}/config/status_exchange.yml"
      end
    end
  end

  desc "Test compilation of the Jekyll static site. Fail the build if it doesn't compile."
  task :compilation => :environment do
    if system "bundle exec jekyll --config=config/jekyll.yml"
      exit 0
    else
      puts "Jekyll site failed to compile."
      exit $?
    end
  end
end

desc "Extend with test:compilation"
#task :test => ['test:prepare:configuration', 'test:run', 'test:compilation']
