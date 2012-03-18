# require 'rake'

load 'deploy' if respond_to?(:namespace) # cap2 differentiator

# Keep tasks in a central location so they can be picked up by both Capistrano and Rake
Dir['/lib/tasks/*.rake'].each {|file| import file }

# Deploy configuration lives in the config dir
load 'cfg/deploy'
