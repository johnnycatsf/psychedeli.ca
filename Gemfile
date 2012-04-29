source :rubygems

gem 'rack', :require => false
gem 'rack-contrib'
gem 'i18n'
gem 'activesupport', '~> 3.2'
gem 'actionpack', '~> 3.2'

group :deployment do
  gem 'rvm'
  gem 'rake', :require => false
  gem 'rvm-capistrano', :require => "rvm/capistrano"
  gem 'capistrano'
  gem 'capistrano_colors'
end

group :assets do
  gem 'sprockets'
  gem 'sprockets-sass'
  gem 'sass'
  gem 'compass'
  gem 'bootstrap-sass'
  gem 'handlebars_assets'
  gem 'coffee-script'
  gem 'redcarpet'
end

group :status_exchange do
  gem 'yajl-ruby'
  gem 'twitter'
  gem 'koala'
  gem 'ratom'
end

group :content do
  gem 'liquid'
  gem 'jekyll', :git => 'git://github.com/tubbo/jekyll.git', :branch => 'feature/custom-dirs'
end

## Environments

group :development do
  gem 'thin'
end

group :test do
  gem 'turn'
  gem 'minitest'
  gem 'mini_specunit'
  gem 'mini_shoulda'
  gem 'simplecov'
  gem 'rack-test'
  gem 'vcr', '2.0.0'
  gem 'mocha'
  gem 'webmock'
  gem 'capybara', :require => false
  gem 'capybara_minitest_spec', :require => false
end

group :production do
  gem 'unicorn'
end
