source 'https://rubygems.org'
ruby '2.1.1'
gem 'rails', '4.1.0'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'bootstrap-sass', '>= 3.0.0.0'
gem 'cancan'
gem 'devise'
gem 'figaro'
gem 'rolify'
gem 'simple_form'
gem 'therubyracer', platform: :ruby
gem 'unicorn'
gem 'unicorn-rails'
gem 'rails_admin', git: 'https://github.com/sferik/rails_admin.git'
gem 'amistad'
gem 'newrelic_rpm'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', group: :development

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'sprockets_better_errors'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', platforms: [:mri_19, :mri_20, :rbx]
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', require: false
  gem 'rb-inotify', require: false
end

group :development, :test do
  gem 'sqlite3'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'faker'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'database_cleaner'
end
