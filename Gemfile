source 'https://rubygems.org'
gem 'rails'
gem 'sass-rails'
gem 'compass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'handlebars_assets'
gem 'turbolinks'
gem 'jbuilder'
gem 'figaro'
gem 'simple_form'
gem 'therubyracer', platform: :ruby
gem 'unicorn'
gem 'unicorn-rails'
gem 'rails_admin', git: 'https://github.com/sferik/rails_admin.git'
gem 'newrelic_rpm'
gem 'geokit-rails'

# User model
gem 'rolify'
gem 'cancan'
gem 'devise'
gem 'acts_as_friendable', git: 'https://github.com/rhannequin/acts_as_friendable.git'
gem 'acts-as-taggable-on'
gem 'mailboxer'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', group: :doc

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
  gem 'json_spec'
end
