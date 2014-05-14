# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.

require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token. (chomp removes record separator - if present)
    File.read(token_file).chomp 
  else
    # Generate a new token and store it in token_file
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end
    
SampleApp::Application.config.secret_key_base = '2353e71448bba0546e917a5ab0e78ef747c0c5ea68f5437eeb381490f399c5544a1eb04d9cc12cb67301015176841a095cf2cb0ffcee3d8e4111532a1f5d603e'
