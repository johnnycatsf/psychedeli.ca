require 'bundler'
Bundler.setup :framework, :deployment

set :rvm_ruby_string, '1.9.3-p125@psychedelica'
set :rvm_type, :user
set :user, "necromancer"
set :domain, "psychedeli.ca"
set :use_sudo, true

require "rvm/capistrano"

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
    run "gem install bundler"
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
end

# Always restart the app after deployment
after 'deploy:update_code', 'deploy:update_content'
