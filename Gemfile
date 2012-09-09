source 'https://rubygems.org'

gem 'rails', '3.2.7'
gem 'pg'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :views do
  gem "bootstrap-sass", ">= 2.0.3"
  gem 'jquery-rails'
  gem "haml", ">= 3.1.6"
  gem 'jbuilder'
  gem 'builder'
  gem 'hpricot'
  gem 'ruby_parser'
end

group :active_document do
  gem 'liquid'
  gem 'pygments.rb'
  gem 'redcarpet'
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
  gem "guard-bundler", ">= 0.1.3"
  gem "guard-rails", ">= 0.0.3"
  gem "guard-livereload", ">= 0.3.0"
  gem 'guard-minitest'
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
  gem 'ruby-prof'
end

group :production do
  gem 'syslogger'
  gem 'unicorn'
end

