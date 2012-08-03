#
# psychedeli.ca deployment configuration
#

require 'bundler/capistrano'

## General Settings

set :user, "necromancer"
set :domain, "psychedeli.ca"
set :use_sudo, true

set :rvm_ruby_string, '1.9.3-p125@psychedelica'
set :rvm_type, :user

require 'rvm/capistrano'

server domain, :web

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :repository, "git@github.com:tubbo/psychedeli.ca.git"
set :scm, "git"
set :git_enable_submodules, 1

set :application, "blog"
set :deploy_to, "/home/#{user}/src/#{application}"
role :web, "psychedeli.ca"
set :rails_env, 'production'
set :application_server, "unicorn"

## Task Chain

after 'deploy:update', 'deploy:configuration'
before 'deploy:assets:precompile', 'deploy:update_content'

## Task Definitions

namespace :deploy do
  desc "Clear and recreate the pub/ directory with the compiled Jekyll site."
  task :update_content do
    run "cd #{current_path}; bundle exec rake compile"
  end

  desc "Link StatusExchange configuration from shared path."
  task :configuration do
    run "ln -nfs #{shared_path}/cfg/status_exchange.yml #{current_path}/config/status_exchange.yml"
  end

  desc "Restart the application server"
  task :restart do
    case application_server
    when "unicorn"
      restart_unicorn!
    when "passenger"
      run "cd #{release_path}; touch tmp/restart.txt"
    else
      puts "Restart #{application_server} manually."
    end
  end
end

namespace :unicorn do
  desc "Start Unicorn, the production application server."
  task :start do
    if remote_file_exists?(unicorn_pid)
      if remote_process_exists?(unicorn_pid)
        logger.important("Unicorn is already running!", "Unicorn")
        next
      else
        run "rm #{unicorn_pid}"
      end
    end

    config_path = "#{current_path}/config/unicorn.rb"

    if remote_file_exists?(config_path)
      logger.important("Starting...", "Unicorn")
      run "cd #{current_path} && BUNDLE_GEMFILE=#{current_path}/Gemfile bundle exec unicorn -E #{rails_env} -c #{config_path} -D"
    else
      logger.important("Config file for unicorn was not found at \"#{config_path}\"", "Unicorn")
    end
  end

  desc "Stop Unicorn"
  task :stop do
    if remote_file_exists?(unicorn_pid)
      if remote_process_exists?(unicorn_pid)
        logger.important("Stopping...", "Unicorn")
        run "#{try_sudo} kill `cat #{unicorn_pid}`"
      else
        run "rm #{unicorn_pid}"
        logger.important("Unicorn is not running.", "Unicorn")
      end
    else
      logger.important("No PIDs found. Check if unicorn is running.", "Unicorn")
    end
  end

  desc "Gracefully shut down Unicorn"
  task :graceful_stop do
    if remote_file_exists?(unicorn_pid)
      if remote_process_exists?(unicorn_pid)
        logger.important("Stopping...", "Unicorn")
        run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
      else
        run "rm #{unicorn_pid}"
        logger.important("Unicorn is not running.", "Unicorn")
      end
    else
      logger.important("No PIDs found. Check if unicorn is running.", "Unicorn")
    end
  end

  desc "Restart Unicorn, wait for all workers to stop running, then start it again."
  task :reload do
    restart_unicorn!
  end
end

## Helper Methods

# Return Unicorn server PID file
def unicorn_pid
  "#{current_path}/tmp/pids/unicorn.pid"
end

# Check if file exists on server
def remote_file_exists?(full_path)
  'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

# Check if process is running
def remote_process_exists?(pid_file)
  capture("ps -p $(cat #{pid_file}) ; true").strip.split("\n").size == 2
end

def restart_unicorn!
  if remote_file_exists?(unicorn_pid)
    logger.important("Stopping...", "Unicorn")
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  else
    logger.important("No PIDs found. Starting Unicorn server...", "Unicorn")
    config_path = "#{current_path}/config/unicorn.rb"
    if remote_file_exists?(config_path)
      run "cd #{current_path} && BUNDLE_GEMFILE=#{current_path}/Gemfile bundle exec unicorn -E #{rails_env} -c #{config_path} -D"
    else
      logger.important("Config file for unicorn was not found at \"#{config_path}\"", "Unicorn")
    end
  end
end
