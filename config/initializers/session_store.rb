# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_todolist_session',
  :secret      => '35ed114d1b146405846de8db4a7bdbf6566f75b16cde87eeb59917d2833cf6b007caa28ba643a6d6ba8c8f28a3bc2ad7068ce0eafbc0eab28ed2b0094e9c5248'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
