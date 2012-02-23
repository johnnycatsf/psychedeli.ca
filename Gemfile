source :rubygems

# backend
gem 'rack', :require => false
gem 'rack-contrib', :require => false
gem 'jekyll', :require => false, git: 'git://github.com/tubbo/jekyll.git', branch: 'feature/custom-dirs'
gem 'sprockets', :require => false
gem 'rake'

# frontend
gem 'liquid', :require => false
gem 'sass'
gem 'compass', :require => false
gem 'redcarpet', '~> 1.17.2'
gem 'uglifier'
gem 'execjs', :require => false
gem 'therubyracer', :require => false

group :development do
  gem 'deadweight', :require => false
end

group :status_exchange do
  gem 'yajl-ruby'
  gem 'twitter'
  gem 'mogli'
  gem 'ratom'
  gem 'soundcloud'
end

group :deployment do
  gem 'capistrano', :require => false
  gem 'heroku', :require => false
  gem 'jammit', :require => false
end
