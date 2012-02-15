namespace :deploy do
  task :after_deploy do
    exec 'rm -rf pub/*'
    exec 'bundle exec jekyll --config=cfg/jekyll.yml'
    exec 'cp cfg/.htaccess pub/.htaccess'
    exec 'cp cfg/robots.txt pub/robots.txt'
  end
