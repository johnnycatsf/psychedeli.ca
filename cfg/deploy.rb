require './lib/tasks/psychedelica.rake'

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

before 'deploy:update_code', 'setup'
after 'deploy:update_code', 'restart'  # Always restart the app after deployment
