desc "Compiles the application with Jekyll"
task :compile do
  puts "Recompiling static assets..."
  # refresh and compile the static dir
  system 'rm -rf pub/*'
  system 'bundle exec jekyll --config=cfg/jekyll.yml'
  # special configuration that gets loaded at the root of the static dir
  system 'cp cfg/.htaccess pub/.htaccess'
  system 'cp cfg/robots.txt pub/robots.txt'
  puts "done"
end

desc "Restarts the Rack stack"
task :restart do
  puts "Restarting the Rack server..."
  system 'touch tmp/restart.txt'
  puts "done"
end
