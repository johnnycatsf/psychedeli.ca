load 'deploy' if respond_to?(:namespace) # cap2 differentiator

# Keep tasks in a central location so they can be picked up by both Capistrano and Rake
Dir[File.dirname(__FILE__) + '/lib/tasks/*.rake'].each {|file| require file }

# Deploy configuration lives in
load 'cfg/deploy'
