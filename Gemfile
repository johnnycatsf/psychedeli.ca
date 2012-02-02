source :rubygems

group :application do
  # backend
  gem 'rack', :require => false
  gem 'rack-contrib', :require => false
  gem 'jekyll', git: 'git://github.com/tubbo/jekyll.git', branch: 'feature/custom-dirs', :require => false
  gem 'sprockets', :require => false
  gem 'thor', :require => false

  # frontend
  gem 'liquid', :require => false
  gem 'sass'
  gem 'compass', :require => false
  gem 'redcarpet', :require => false
  gem 'uglifier'
  gem 'execjs', :require => false
  gem 'therubyracer', :require => false
end

group :development do
  gem 'deadweight', :require => false
end

group :status_exchange do
  gem 'yajl-ruby'
  gem 'twitter'
  gem 'mogli'
  gem 'ratom'
end

group :deployment do
  gem 'capistrano', :require => false
  gem 'heroku', :require => false
  gem 'jammit', :require => false
end
