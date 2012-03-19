source :rubygems

# Framework
gem 'rack', :require => false
gem 'rack-contrib', :require => false
gem 'jekyll', :require => false, :git => 'git://github.com/tubbo/jekyll.git', :branch => 'feature/custom-dirs'
gem 'sprockets', :require => false
gem 'rake'
gem 'activesupport', :require => false

# Asset pipeline
gem 'sprockets', :require => false
gem 'sass'
gem 'compass', :require => false
gem 'redcarpet', '~> 1.17.2'
gem 'uglifier'
# gem 'execjs', :require => false
# gem 'therubyracer', :require => false

# Jekyll
gem 'jekyll', :require => false, git: 'git://github.com/tubbo/jekyll.git', branch: 'feature/custom-dirs'
gem 'liquid', :require => false

# StatusExchange
gem 'yajl-ruby'
gem 'twitter'
gem 'koala'
gem 'ratom'
gem 'soundcloud'

# Development tools
group :development do
  gem 'unicorn', :require => false
end
group :deployment do
  gem 'capistrano', :require => false
  gem 'heroku', :require => false
  gem 'jammit', :require => false
end
group :test do
  gem 'minitest'
  gem 'mini_shoulda'
  gem 'turn'
  gem 'rack-test'
  gem 'vcr'
  gem 'webmock'
end
