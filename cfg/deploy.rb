# = Deployment Configuration
#
# Deployment is handled with Capistrano. Via the Capfile, this configuration is
# called when <tt>cap deploy</tt> is run from the shell.

# == Authentication
#
# When deployments happen, always log in as <tt>necromancer@psychedeli.ca</tt>
# (make sure the proper key is set up) and set <tt>psychedeli.ca</tt> to be the
# domain for all 3 roles.
set :user, "necromancer"
set :domain, "psychedeli.ca"
server domain, :app, :web
role :db, domain, :primary => true

# == Application
#
# Where to put the application once it reaches the server, and what it's called
set :application, "blog"
set :deploy_to, "/home/#{user}/src/#{application}"

# == Version control
#
# Uses a private git server for source control, hosted on psychedeli.ca. This
# section also configures a number of SSH options since Git relies so heavily
# on SSH for communication.
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :repository, "git@psychedeli.ca:code/blog.git"
set :scm, "git"
set :user, "necromancer"
set :use_sudo, true
set :git_enable_submodules, 1

# == Passenger
#
# psychedeli.ca is powered by Passenger. Here's a deploy task that makes#
# restarting a bit easier.
namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

# Always restart the app after deployment
after :deploy, "passenger:restart"
