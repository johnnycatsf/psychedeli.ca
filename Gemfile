# f = File.open('/tmp/load_path', 'w')
# f.write($:)
# f.close

source :rubygems

group :framework do
  gem 'rack', :require => false
  gem 'sprockets', :require => false
  gem 'rack-contrib', :require => false
  gem 'i18n'
  gem 'activesupport', '~> 3.2'
  gem 'actionpack', '~> 3.2'
end

group :assets do
  gem 'actionpack', '~> 3.2'
  gem 'compass'
  gem 'sass-rails', '~> 3.2'
  gem 'bootstrap-sass', '~> 2.0.2'
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

gem 'liquid'
gem 'jekyll', :git => 'git://github.com/tubbo/jekyll.git', :branch => 'feature/custom-dirs'
gem 'rake'
gem 'capistrano'
gem 'capistrano_colors'
gem 'thin'

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
  # gem 'capybara'
  # gem 'capybara_minitest_spec'
end
