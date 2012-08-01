source :rubygems

# Components

gem 'rack', require: false
gem 'rack-contrib'
gem 'i18n', require: false
gem 'actionpack', '3.2.0', require: false
gem 'activesupport', '3.2.0', require: 'active_support/all'
gem 'sprockets'
gem 'rvm', require: false
gem 'thin'
gem 'vcr', '2.2.3'
gem 'rake'

group :content do
  gem 'liquid'
  gem 'jekyll', git: 'git://github.com/tubbo/jekyll.git', branch: 'custom-posts-directory'
  gem 'pygments.rb'
  gem 'redcarpet'
end

group :assets do
  gem 'sprockets-sass'
  gem 'sass'
  gem 'compass'
  gem 'bootstrap-sass'
  gem 'handlebars_assets'
  gem 'coffee-script'
end

group :status_exchange do
  gem 'yajl-ruby'
  gem 'twitter'
  gem 'koala'
  gem 'ratom', require: 'atom'
end

group :deployment do
  gem 'rvm-capistrano', require: false
end

# Environments

group :development do
  gem 'capistrano', require: false
  gem 'capistrano_colors', require: false
end

group :test do
  gem 'turn', '>= 0.9.3'
  gem 'minitest'
  gem 'mini_specunit'
  gem 'mini_shoulda'
  gem 'rack-test'
  gem 'mocha'
  gem 'webmock'
end

group :production do
  gem 'unicorn'
end
