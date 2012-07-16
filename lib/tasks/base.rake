desc "Copy server configuration files from `cfg/` to the public dir."
task :config do
  puts "Copying configuration..."
  system 'cp cfg/.htaccess pub/.htaccess'
  system 'cp cfg/robots.txt pub/robots.txt'
  system 'cp cfg/status_exchange.yml.example cfg/status_exchange.yml' unless File.exists? File.expand_path('./cfg/status_exchange.yml')
  system 'mkdir -p pub/err; cp -R app/err/*.html pub/err'
end

desc "Compile the static HTML and Markdown content in `app/` with Jekyll"
task :compile do
  puts "Compiling blog content..."
  # refresh and compile the static dir
  system 'rm -rf pub/*'
  system 'bundle exec jekyll --config=cfg/jekyll.yml'
end

desc "Run the test suite on CI"
task :build => [:compile, :config, :test]

# desc "Build the site, test the code and restart the server"
task :default => [:compile, :test]
