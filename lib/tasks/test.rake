namespace :test do
  desc "Configure the test environment"
  task :prepare => :environment do
    unless File.exists? "#{Rails.root}/config/status_exchange.yml"
      cp "#{Rails.root}/config/status_exchange.yml.example", "#{Rails.root}/config/status_exchange.yml"
    end

    Rake::Task['test:prepare'].invoke
  end
end
