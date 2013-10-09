# Authenticatable REST API

This project was based heavily on the walkthrough written by Eric Berry that you can find [here](http://coderberry.me/blog/2013/07/08/authentication-with-emberjs-part-1/ "Ember.js authentication project"). The additions / changes I've made are addressed below.

Check out the [rails-api](https://github.com/rails-api/rails-api "Rails-API GitHub project") gem as well. It serves as the base.

## Additions and changes

+ Added CORS header support, as well as preflight options response
+ Using [faker](https://github.com/stympy/faker "Faker gem") for populating test data
+ Modified api key scoping
+ Added a field to lock the api key, and for the last login time
+ Modified how api keys are created and expired. If the client sends an expired token whose key hasn't been locked, a new token will be generated. When the user logs out, the token is removed and the key is expired.
+ When editing the user profile, you must supply the current user's password, even if you have a valid token
+ There will only be one api key per user per scope, the token will change as the user logs out or the token api key expires.
+ Added some static public pages to describe the API
+ Replaced default unit tests with RSpec equivalents

## Configuration and deployment

Make sure all the gems are installed
    bundle install

Run migrations for development and testing
    rake db:migrate; rake db:migrate RAILS_ENV=test

Run tests, if you'd like
    rake

Populate the database with fake data
    rake db:populate

Start the server
    unicorn

Push to Heroku and populate data (after initializing your git repository, and creating your heroku app, of course)
    git push heroku master
    heroku run rake db:migrate; rake db:populate

## Todo

+ Omni-Auth support
+ Additional data relationships that are tied to the user
