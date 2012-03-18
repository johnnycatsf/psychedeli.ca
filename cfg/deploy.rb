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

namespace :deploy do
  desc "Restart the server and recompile the app"
  task :update_content do
    system "cd #{current_release}; rm -rf pub/*"
    system "cd #{current_release}; bundle exec jekyll --config=cfg/jekyll.yml"
  end
  task :restart do
    system "cd #{current_release}; touch tmp/restart.txt"
  end
end

# Always restart the app after deployment
after 'deploy:update_code', 'deploy:update_content'
