require '../lib/tasks'

set :user, "necromancer"
set :domain, "psychedeli.ca"
server domain, :web

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :repository, "git@github.com:tubbo/psychedeli.ca.git"
set :scm, "git"
set :user, "necromancer"
set :use_sudo, true
set :git_enable_submodules, 1

set :application, "blog"
set :deploy_to, "/home/#{user}/src/#{application}"
role :web, "psychedeli.ca"

namespace :rack do
  desc "Restart the server"
  task :restart do
    run "cd #{deploy_to}/current && /usr/bin/env rake compile RAILS_ENV=production"
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after 'deploy:update_code', 'rack:restart'  # Always restart the app after deployment
