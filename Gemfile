source :rubygems

group :framework do
  gem 'rack', :require => false
  gem 'sprockets', :require => false
  gem 'rack-contrib'
  gem 'i18n'
  gem 'activesupport', '~> 3.2'
  gem 'actionpack', '~> 3.2'
  gem 'unicorn', :require => false
end

group :deployment do
  gem 'rvm'
  gem 'rake', :require => false
  gem 'rvm-capistrano', :require => "rvm/capistrano"
  gem 'capistrano'
  gem 'capistrano_colors'
end

group :assets do
  gem 'actionpack', '~> 3.2'
  gem 'sass'
  gem 'redcarpet', '~> 1.17.2'
  gem 'uglifier'
  gem 'libv8'
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
