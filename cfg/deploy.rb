#
# psychedeli.ca deployment configuration
#

## Settings

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

## Tasks

namespace :deploy do
  desc "Clear and recreate the pub/ directory with the compiled Jekyll site."
  task :update_content do
    run "cd #{current_path}; rm -rf pub/*"
    run "cd #{current_path}; bundle exec jekyll --config=cfg/jekyll.yml"
  end

  desc "Install Bundler (if necessary) and gemset"
  task :install_dependencies do
    unless remote_file_exists? 'bundle'
      run "cd #{current_path}; gem install bundler"
    end

    run "cd #{current_path}; bundle install"
  end

  desc "Start the Unicorn server."
  task :restart do
    run "cd #{current_path}; unicorn -c cfg/unicorn.rb"
  end
end

namespace :configure do
  desc "Link StatusExchange configuration from shared path."
  task :status_exchange do
    run "ln -nfs #{shared_path}/cfg/status_exchange.yml #{current_path}/cfg/status_exchange.yml"
  end
end

namespace :clean do
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

    config_path = "#{current_path}/config/unicorn.rb"
    if remote_file_exists?(config_path)
      logger.important("Starting...", "Unicorn")
      run "cd #{current_path} && rvmsudo BUNDLE_GEMFILE=#{current_path}/Gemfile bundle exec unicorn_rails -E #{rails_env} -c #{config_path} -D"
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
        run "cd #{current_path} && rvmsudo BUNDLE_GEMFILE=#{current_path}/Gemfile bundle exec unicorn_rails -E #{rails_env} -c #{config_path} -D"
      else
        logger.important("Config file for unicorn was not found at \"#{config_path}\"", "Unicorn")
      end
    end
  end
end

## Helper Methods

# Return Unicorn server PID file
def unicorn_pid
  "#{current_path}/tmp/pids/unicorn.#{application}.#{rails_env}.pid"
end

# Check if file exists on server
def remote_file_exists?(full_path)
  'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

# Check if process is running
def remote_process_exists?(pid_file)
  capture("ps -p $(cat #{pid_file}) ; true").strip.split("\n").size == 2
end

## Task Chain

after 'deploy:update_code', 'deploy:install_dependencies'
after 'deploy:install_dependencies', 'deploy:update_content'
after 'deploy:update_content', 'configure:status_exchange'
after 'configure_status_exchange', 'clean:capistrano_assumptions'
# after 'clean:capistrano_assumptions', 'unicorn:reload'
