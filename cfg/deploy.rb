#
# psychedeli.ca deployment configuration
#

## General Settings

set :user, "necromancer"
set :domain, "psychedeli.ca"
set :use_sudo, true

set :rvm_ruby_string, '1.9.3-p125@psychedelica'
set :rvm_type, :user

require 'rvm/capistrano'
require 'bundler/capistrano'

server domain, :web

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :repository, "git@github.com:tubbo/psychedeli.ca.git"
set :scm, "git"
set :git_enable_submodules, 1

set :application, "blog"
set :deploy_to, "/home/#{user}/src/#{application}"
role :web, "psychedeli.ca"
set :rack_env, 'production'

## Task Chain

after 'deploy', 'deploy:bundle', 'deploy:update_content', 'deploy:configuration',
      'deploy:clean_capistrano_assumptions', 'unicorn:reload'

## Task Definitions

namespace :deploy do
  desc "Clear and recreate the pub/ directory with the compiled Jekyll site."
  task :update_content do
    run "cd #{current_path}; rm -rf pub/*"
    run "cd #{current_path}; bundle exec jekyll --config=cfg/jekyll.yml"
  end

  desc "Link StatusExchange configuration from shared path."
  task :configuration do
    run "ln -nfs #{shared_path}/cfg/status_exchange.yml #{current_path}/cfg/status_exchange.yml"
  end

  desc "Remove the public/ directory, an assumed link set up by Capistrano for Rails apps."
  task :capistrano_assumptions do
    run "cd #{release_path}; rm -rf public/"
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

    config_path = "#{current_path}/cfg/unicorn.rb"

    if remote_file_exists?(config_path)
      logger.important("Starting...", "Unicorn")
      run "cd #{current_path} && BUNDLE_GEMFILE=#{current_path}/Gemfile bundle exec unicorn -E #{rack_env} -c #{config_path} -D"
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
    if remote_file_exists?(unicorn_pid)
      logger.important("Stopping...", "Unicorn")
      run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
    else
      logger.important("No PIDs found. Starting Unicorn server...", "Unicorn")
      config_path = "#{current_path}/cfg/unicorn.rb"
      if remote_file_exists?(config_path)
        run "cd #{current_path} && BUNDLE_GEMFILE=#{current_path}/Gemfile bundle exec unicorn -E #{rack_env} -c #{config_path} -D"
      else
        logger.important("Config file for unicorn was not found at \"#{config_path}\"", "Unicorn")
      end
    end
  end
end

## Helper Methods

# Return Unicorn server PID file
def unicorn_pid
  "#{current_path}/tmp/pids/unicorn.#{application}.#{rack_env}.pid"
end

# Check if file exists on server
def remote_file_exists?(full_path)
  'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

# Check if process is running
def remote_process_exists?(pid_file)
  capture("ps -p $(cat #{pid_file}) ; true").strip.split("\n").size == 2
end
