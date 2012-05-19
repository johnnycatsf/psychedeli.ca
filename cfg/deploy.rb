require 'bundler'
Bundler.setup :framework, :deployment


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

namespace :deploy do
  task :update_content do
    run "cd #{release_path}; bundle install"
    run "cd #{release_path}; rm -rf pub/*"
    run "cd #{release_path}; bundle exec jekyll --config=cfg/jekyll.yml"
    configure_status_exchange
  end

  task :configure_status_exchange do
    run "ln -nfs #{shared_path}/cfg/status_exchange.yml #{release_path}/cfg/status_exchange.yml"
  end

  task :restart do
    run "cd #{release_path}; touch tmp/restart.txt"
  end

  task :cleanup_capistrano_assumptions do
    run "cd #{release_path}; rm -rf public/"
  end
end

# Always restart the app after deployment
after 'deploy:update_code', 'deploy:update_content'
after 'deploy:update_content', 'deploy:cleanup_capistrano_assumptions'
after "deploy:restart", "unicorn:reload"

# Unicorn tasks
namespace :unicorn do
  desc 'Start Unicorn'
  task :start, :roles => :app, :except => {:no_release => true} do
    if remote_file_exists?(unicorn_pid)
      if process_exists?(unicorn_pid)
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

  desc 'Stop Unicorn'
  task :stop, :roles => :app, :except => {:no_release => true} do
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

  desc 'Unicorn graceful shutdown'
  task :graceful_stop, :roles => :app, :except => {:no_release => true} do
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

  desc 'Reload Unicorn'
  task :reload, :roles => :app, :except => {:no_release => true} do
    if remote_file_exists?(unicorn_pid)
      logger.important("Stopping...", "Unicorn")
      run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
    else
      logger.important("No PIDs found. Starting Unicorn server...", "Unicorn")
      config_path = "#{current_path}/config/unicorn.rb"
      if remote_file_exists?(config_path)
        run "cd #{current_path} && rvmsudo BUNDLE_GEMFILE=#{current_path}/Gemfile bundle exec unicorn_rails -E #{rails_env} -c #{config_path} -D"
      else
        logger.important("Config file for unicorn was not found at \"#{config_path}\"", "Unicorn")
      end
    end
  end
end
def unicorn_pid
  "#{current_path}/tmp/pids/unicorn.#{application}.#{rails_env}.pid"
end

def remote_file_exists?(full_path)
  'true' ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

# Check if process is running
#
def remote_process_exists?(pid_file)
  capture("ps -p $(cat #{pid_file}) ; true").strip.split("\n").size == 2
end
