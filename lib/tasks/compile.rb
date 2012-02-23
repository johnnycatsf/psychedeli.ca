desc "Compiles the application with Jekyll"
task :compile do
  # refresh and compile the static dir
  system 'rm -rf pub/*'
  system 'bundle exec jekyll --config=cfg/jekyll.yml'
  # special configuration that gets loaded at the root of the static dir
  system 'cp cfg/.htaccess pub/.htaccess'
  system 'cp cfg/robots.txt pub/robots.txt'
end
