# Tasks for running the development server, Thin.
namespace :server do
  desc "Start the application server"
  task :start do
    puts "Starting psychedeli.ca on port 3000..."
    system "thin -C cfg/thin.yml start"
  end
end

task :server => ['server:start']
