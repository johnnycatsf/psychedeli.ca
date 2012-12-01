source 'https://rubygems.org'

gem 'rails', '3.2.7'
gem 'pg'
gem 'newrelic_rpm'

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
  gem 'pjax_rails'
end

group :active_copy do
  gem 'liquid'
  gem 'pygments.rb', '~> 0.3'
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
  gem 'growl'
  gem 'rb-fsevent'
  gem 'guard-rails'
  gem 'guard-bundler'
  gem 'guard-livereload'
  gem 'guard-rspec'
end

gem 'thin', group: [:development, :stage]

group :stage do
  gem 'jammit', require: false
end

group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'rspec-rails'
  gem 'ruby-prof'
end

group :production do
  gem 'syslogger'
  gem 'unicorn'
end

