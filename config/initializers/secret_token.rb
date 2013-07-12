# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

# Although this is not needed for an api-only application, rails4
# requires secret_key_base or secret_toke to be defined, otherwise an
# error is raised.
# Using secret_token for rails3 compatibility. Change to secret_key_base
# to avoid deprecation warning.
# Can be safely removed in a rails3 api-only application.
RestApi::Application.config.secret_key_base = 'c4ab9d9b4bc8002a0d4a37fc1ce1d1f31f580e2c41ad4240d2f80181b1ffeb2bf9ec5c50df78090e55ccea04d4b1f4ebdda7a274be699a15c408c2b5dc779eb7'
