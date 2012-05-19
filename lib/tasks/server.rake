# Tasks for running the development server, Thin.
namespace :server do
  desc "Start the application server as a daemon, with logs written to log/application.log"
  task :start do
    puts "Starting Thin..."
    system "thin -c cfg/thin.yml"
  end

  desc "Stop the application server."
  task :stop do
    if File.exists? thin_process_id
      puts "Stopping Thin..."
      system "kill -s USR2 `cat tmp/pids/thin.pid`"
    else
      puts "Thin has not started."
    end
  end

  desc "Restart the application server."
  task :restart => [:stop, :start]
end
