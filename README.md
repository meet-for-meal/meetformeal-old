# Meetformeal

## Requirements

* ruby 2.1.1
* rails 4.1.0
* gem bundler: `gem install bundler`

## Install

Create `config/application.yml` from `config/application.example.yml`. Don't forget to change some data with your own information, like `FOURSQUARE_TOKEN`, `GMAIL_USERNAME`, `GMAIL_PASSWORD`.

Then run:

    bundle install
    bundle exec rake db:crate
    bundle exec rake db:migrate
    bundle exec rake db:prepare

## Launch

    bundle exec rails s

## Test

    bundle exec rspec
