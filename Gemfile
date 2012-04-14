source :rubygems

group :framework do
  gem 'rack', :require => false
  gem 'sprockets', :require => false
end

group :content do
  gem 'rack-contrib', :require => false
  gem 'liquid'
end

group :assets do
  gem 'sass'
  gem 'compass'
  gem 'redcarpet', '~> 1.17.2'
  gem 'uglifier'
  gem 'libv8'
end

group :status_exchange do
  gem 'yajl-ruby'
  gem 'twitter'
  gem 'koala'
  gem 'ratom'
  # gem 'soundcloud'
end

group :content, :status_exchange do
  gem 'i18n'
  gem 'activesupport', :require => false
end

group :development do
  gem 'jekyll', :git => 'git://github.com/tubbo/jekyll.git', :branch => 'feature/custom-dirs'
  gem 'rake'
  gem 'capistrano'
  gem 'capistrano_colors'
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
  gem 'actionpack'
  # gem 'capybara'
  # gem 'capybara_minitest_spec'
end
