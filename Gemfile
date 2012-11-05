source 'https://rubygems.org'

gem 'rails', '3.2.7'
gem 'pg'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :views do
  gem 'bootstrap-sass', git: 'git://github.com/trisweb/bootstrap-sass.git'
  gem 'jquery-rails'
  gem "haml", ">= 3.1.6"
  gem 'jbuilder'
  gem 'builder'
  gem 'hpricot'
  gem 'ruby_parser'
  gem 'underscore-rails'
  gem 'draper'
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

group :deployment do
  gem 'capistrano'
  gem 'capistrano_colors'
  gem 'rvm-capistrano', require: false
  gem 'bundler', require: false
end

group :development do
  gem "haml-rails", ">= 0.3.4"
  gem 'pry'
  gem 'pry-doc'
end

group :automated_testing do
  gem 'growl'
  gem 'rb-fsevent'
  gem "guard-bundler"
  gem "guard-rails"
  gem "guard-livereload"
  gem "guard-minitest"
end

gem 'thin', group: [:development, :stage]

group :stage do
  gem 'heroku'
  gem 'jammit', require: false
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

