source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0', require: false
gem 'pg'
gem 'newrelic_rpm'
gem 'puma'
gem 'foreman'
gem 'airbrake'
gem 'heroku', :require => false

group :assets do
  gem 'jquery-rails'
  gem 'sass-rails',   '~> 4.0'
  gem 'coffee-rails', '~> 4.0'
  gem 'uglifier', '>= 1.3'
  gem 'pjax_rails' # TODO: used?
  gem 'sumatra-rails', '0.0.6.1'
  gem 'underscore-rails'
  gem 'zurb-foundation', '~> 4.0'
  gem 'foundation-icons-sass-rails'
end

group :views do
  gem "haml-rails", '~> 0.4'
  gem 'draper'
  gem 'high_voltage'
end

group :active_copy do
  gem 'pygments.rb', '~> 0.3'
  gem 'redcarpet'
end

group :doc do
  gem 'sdoc'
end

group :development do
  gem 'meta_request'
end

group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'rspec-rails'
  gem 'capybara'
end

group :development, :test do
  gem 'pry-rails'
end

group :production do
  gem 'rack-cache'
  gem 'asset_sync'
  gem 'rails_12factor'
end
