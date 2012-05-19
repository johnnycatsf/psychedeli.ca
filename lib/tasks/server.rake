namespace :server do
  desc "Runs the server, which is Thin in development and Unicorn in production"
  task :start do
    server =  if ENV['RACK_ENV'] == 'production'
                { name: 'Unicorn', command: 'unicorn -p 3000 -D' }
              else
                Rake::Task[:compile].invoke
                { name: 'Thin', command: 'thin -p 3000 -D start' }
              end

    puts "Starting #{server[:name]}..."
    system server[:command]
  end

  task :stop do
    if File.exists? thin_process_id
      puts "Stopping Thin..."
      system "kill -s USR2 `cat #{thin_process_id}`"
    else
      puts "Thin has not started."
    end
  end
end

def thin_process_id
  environment = RACK_ENV || 'development'
  File.expand_path("tmp/pids/thin.#{environment}.pid")
end
