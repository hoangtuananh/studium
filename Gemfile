source 'http://rubygems.org'

gem 'rails', '3.1.0'
  
# Need to put bootstrap outside of assets or else it doesn't work on heroku
gem 'twitter-bootstrap-rails'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
  gem 'therubyracer'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  gem 'cucumber'
  gem "cucumber-rails-training-wheels"
  gem "launchy"
  gem "database_cleaner"
  gem "capybara"
end

group :development,:test do
  gem "rspec-rails"
  gem "ZenTest"
  gem "email_spec"
  gem "ruby-debug19"
  gem "sqlite3"
  gem "simplecov"
end

group :production do
  gem "pg"
end

gem "haml"
gem "haml-rails"
gem "devise"
gem "cancan"
gem "will_paginate"
gem "paperclip"

# Work around; default to rake 0.8.7 because 0.9 breaks rails
gem "rake","0.8.7"
