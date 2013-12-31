source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'rails-api'
gem 'unicorn'
gem 'pg'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'rack-timeout'
gem 'active_model_serializers', :github => 'rails-api/active_model_serializers'

# gem 'omniauth-google-oauth2'

group :development, :test do
	gem 'debugger'
	gem 'rspec-rails'
	gem 'factory_girl_rails'
end

group :test do
  gem 'faker'
  gem 'shoulda-matchers'
end

group :production do
	# List gems here that are only for production on Heroku
	gem 'newrelic_rpm'
end
