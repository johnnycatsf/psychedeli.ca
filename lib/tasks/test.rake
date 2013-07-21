begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new :spec

  desc "Run RSpec and Jasmine code examples"
  task :test => %w(db:test:prepare spec)
rescue LoadError;end
