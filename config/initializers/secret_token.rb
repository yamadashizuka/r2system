# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
R2::Application.config.secret_key_base = '85118fd46c78baace96a6ed609bb733cf803cfff2c62615bf9dc4854edf142b211a46f3ad655557a6e07c4cd0ae9af641594a6c67a3f3328da366b451a0142c2'
