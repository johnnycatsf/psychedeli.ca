source :rubygems

# Components

gem 'rack', :require => false
gem 'rack-contrib'
gem 'i18n', :require => false
gem 'actionpack', '~> 3.2', :require => false
gem 'activesupport', '~> 3.2', :require => 'active_support/all'
gem 'sprockets'

group :content do
  gem 'liquid'
  gem 'jekyll', git: 'git://github.com/tubbo/jekyll.git', branch: 'feature/custom-dirs'
end

group :assets do
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
  gem 'ratom', :require => 'atom'
end

# Environments

group :development do
  gem 'thin', :require => false
  gem 'rvm', :require => false
  gem 'rake', :require => false
  gem 'capistrano', :require => false
  gem 'capistrano_colors', :require => false
  gem 'rvm-capistrano', :require => false
end

group :test do
  gem 'turn', '>= 0.9.3'
  gem 'minitest'
  gem 'mini_specunit'
  gem 'mini_shoulda'
  gem 'rack-test'
  gem 'mocha'
  gem 'vcr'
  gem 'webmock'
  gem 'capybara', :require => false
  gem 'capybara_minitest_spec', :require => false
end

group :production do
  gem 'unicorn'
end
