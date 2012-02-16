task :compile do
  # refresh and compile the static dir
  run 'rm -rf pub/*'
  run 'bundle exec jekyll --config=cfg/jekyll.yml'
  # special configuration that gets loaded at the root of the static dir
  run 'cp cfg/.htaccess pub/.htaccess'
  run 'cp cfg/robots.txt pub/robots.txt'
end
