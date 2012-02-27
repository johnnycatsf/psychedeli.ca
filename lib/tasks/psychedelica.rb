desc "Compiles the application with Jekyll"
task :compile do
  puts "Compiling blog content..."
  # refresh and compile the static dir
  system 'rm -rf pub/*'
  system 'bundle exec jekyll --config=cfg/jekyll.yml'
  # special configuration that gets loaded at the root of the static dir
  system 'cp cfg/.htaccess pub/.htaccess'
  system 'cp cfg/robots.txt pub/robots.txt'
end

desc "Restarts the Rack stack"
task :restart do
  puts "Restarting the server..."
  system 'touch tmp/restart.txt'
  puts "done"
end

desc "Runs all of the tests for psychedeli.ca"
task :test do
  puts "Running tests..."
  puts "No tests have been written for psychedeli.ca yet"
end
