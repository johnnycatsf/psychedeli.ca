# f = File.open('/tmp/load_path', 'w')
# f.write($:)
# f.close

source :rubygems

gem 'rack', :require => false
gem 'sprockets', :require => false
gem 'rack-contrib', :require => false
gem 'liquid'

group :assets do
  gem 'sass'
  gem 'compass'
  gem 'redcarpet', '~> 1.17.2'
  gem 'uglifier'
  gem 'libv8'
end

gem 'yajl-ruby'
gem 'twitter'
gem 'koala'
gem 'ratom'

gem 'i18n'
gem 'activesupport'

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
  gem 'actionpack'
  # gem 'capybara'
  # gem 'capybara_minitest_spec'
end
