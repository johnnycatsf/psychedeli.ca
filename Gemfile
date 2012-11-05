source 'https://rubygems.org'

gem 'rails', '3.2.7'
#gem 'pg'

group :assets do
  gem 'therubyracer'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'less-rails'
end

group :views do
  gem 'twitter-bootstrap-rails'
  gem 'jquery-rails'
  gem "haml", ">= 3.1.6"
  gem 'liquid'
  gem 'jekyll', git: 'git://github.com/tubbo/jekyll.git', branch: 'custom-posts-directory'
  gem 'pygments.rb'
  gem 'redcarpet'
  gem 'jbuilder'
  gem 'builder'
end

group :status do
  gem 'yajl-ruby'
  gem 'twitter'
  gem 'koala'
  gem 'ratom', require: 'atom'
end

group :development do
  gem "haml-rails", ">= 0.3.4"
  gem 'capistrano'
  gem 'growl'
  gem 'rb-fsevent'
  gem "guard-bundler"
  gem "guard-rails"
  gem "guard-livereload"
  gem "guard-minitest"
  gem 'heroku'
  gem 'jammit', require: false
end

gem 'thin', group: [:development, :stage]

group :stage do
  gem 'jammit'
end

group :test do
  gem 'factory_girl_rails'
  gem 'turn', '>= 0.9.3'
  gem 'minitest'
  gem 'mini_specunit'
  gem 'mini_shoulda'
  gem 'rack-test'
  gem 'mocha'
  gem 'vcr'
  gem 'webmock'
end

group :production do
  gem 'syslogger'
  gem 'unicorn'
end

