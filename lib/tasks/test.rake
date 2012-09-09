namespace :test do
  namespace :prepare do
    desc "Copy the status_exchange.yml file from the example in Git. For CI and lazy devs."
    task :configuration => :environment do
      unless File.exists? "#{Rails.root}/config/status_exchange.yml"
        cp "#{Rails.root}/config/status_exchange.yml.example", "#{Rails.root}/config/status_exchange.yml"
      end
    end
  end
end

desc "Extend with test:prepare:configuration"
task :test => ['test:prepare:configuration', 'test:run']
