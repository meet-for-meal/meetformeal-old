# Meetformeal

## Requirements

* ruby 2.1.1
* rails 4.1.0
* gem bundler: `gem install bundler`


## Accounts and applications required

MeetForMeal needs several services to work, such as Foursquare API, Google Maps JavaScript API v3, Places API. You need to create or use accounts from these services to use API keys for the project.

### Foursquare

[Create a Foursquare account](https://fr.foursquare.com/signup) and register to [Foursquare API](https://developer.foursquare.com) to get your API key.

### Google Maps and Google Places

[Create a Google account](https://accounts.google.com/ServiceLogin), connect to [Google Developers Console](https://console.developers.google.com), create a project, and register to Google Maps JavaScript API v3 and Google Places API services. You will get your API key, which is required for MeetForMeal.


## Install

Create `config/application.yml` from [`config/application.example.yml`](https://github.com/meet-for-meal/meetformeal/blob/master/config/application.example.yml). Don't forget to change some data with your own information for the following fields :

- `ADMIN_EMAIL`
- `ADMIN_GENDER`
- `ADMIN_NAME`
- `ADMIN_PASSWORD`
- `FOURSQUARE_TOKEN`
- `GOOGLE_MAPS_KEY`
- `GMAIL_PASSWORD`
- `GMAIL_USERNAME`

Remember it is better to change other values like `COOKIE_STORE_KEY`, `DEVISE_SECRET` or `SECRET_KEY_BASE`.

Then run:

    bundle install
    bundle exec rake db:crate
    bundle exec rake db:migrate
    bundle exec rake db:schema:load
    bundle exec rake db:seed


## Launch

    bundle exec rails s


## Test

    bundle exec rspec
