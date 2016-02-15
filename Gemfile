source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'
gem 'mysql2', group: :development # MYSQL in development
gem 'pg','0.17.1', group: :production # PostgreSQL required for Heroku
gem 'rails_12factor', group: :production # Heroku requirement
gem "figaro", github: 'laserlemon/figaro' # for environment variables
gem 'friendly_id' # for user slugs
gem 'bcrypt', '~> 3.1.7' # Use ActiveModel has_secure_password
gem 'sass-rails', '~> 4.0.3' # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.0.0' # Use CoffeeScript for .js.coffee assets and views
gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'jquery-ui-rails'
gem 'jbuilder', '~> 2.0' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'sdoc', '~> 0.4.0',          group: :doc # bundle exec rake doc:rails generates the API under doc/api.
gem 'spring',        group: :development # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem "letter_opener", :group => :development
gem "parsley-rails" # Add parsley form validation
gem 'roo', '~> 2.1.0'
gem 'exception_notification'

#maps and geocoding
gem 'gmaps4rails', "~> 1.5.6" # For google maps view, geocoding, etc

# Add google font library
gem 'google-webfonts'

#user authentication and management
gem 'omniauth'
gem 'omniauth-facebook'
gem "omniauth-google-oauth2"
gem "omniauth-twitter"

#for file uploads
gem 'carrierwave' # For uploading photos
gem "fog"
gem 'fullcalendar-rails'
gem 'momentjs-rails'

group :development do
  gem "quiet_assets"
  gem 'pry-rails'
  gem "better_errors"
  gem "binding_of_caller"
end

gem 'haml_coffee_assets'
gem 'execjs'
gem 'twilio-ruby', '~> 4.1.0'
# gem 'rmagick'
gem 'ransack'
gem 'best_in_place', '~> 3.0.1'
gem 'carrierwave-crop'


gem 'american_date'

gem 'puma'

#for payments
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'

# Pusher Gem
gem 'pusher'

#for caching
gem 'memcachier'
gem 'dalli'
gem 'actionpack-action_caching'


# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
gem 'remotipart'
