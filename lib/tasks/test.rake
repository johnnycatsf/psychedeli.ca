namespace :test do
  task :watch do
    system 'bundle exec guard'
  end

  Rake::TestTask.new(:integration) do |t|
    t.libs << 'test'
    t.pattern = 'test/integration/*_test.rb'
    t.verbose = true
  end

  Rake::TestTask.new(:units) do |t|
    t.libs << 'test'
    t.pattern = 'test/unit/*_test.rb'
    t.verbose = true
  end

  Rake::TestTask.new(:functionals) do |t|
    t.libs << 'test'
    t.pattern = 'test/unit/*_test.rb'
    t.verbose = true
  end
end

# Run all tests
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end
