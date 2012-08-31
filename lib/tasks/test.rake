namespace :test do
  desc "Configure the test environment"
  task :prepare => :environment do
    cp "#{Rails.root}/config/status_exchange.yml.example", "#{Rails.root}/config/status_exchange.yml"
    Rake::Task['test:prepare'].invoke
  end
end
