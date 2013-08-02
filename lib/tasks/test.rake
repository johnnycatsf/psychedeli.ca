begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new :spec

  desc "Run RSpec and Jasmine code examples"
  task :test => %w(spec teaspoon)
rescue LoadError;end
