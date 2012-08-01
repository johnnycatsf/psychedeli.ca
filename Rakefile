# require 'rake/clean'
require 'rake/testtask'
require 'rake/ext/string'
require 'rake/sprocketstask'

Rake::SprocketsTask.new :js
Rake::SprocketsTask.new :css

Dir["lib/tasks/*.rake"].each {|file| load file }
