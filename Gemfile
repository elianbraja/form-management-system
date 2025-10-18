# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 8.0.3'
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem 'propshaft'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Authentication
gem 'devise'

# Authorization
gem 'pundit'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

group :development, :test do
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'web-console'
end

group :test do
  gem 'faker'
  gem 'shoulda-matchers'
end
