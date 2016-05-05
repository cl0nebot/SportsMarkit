require "omniauth-facebook"
require "omniauth-google-oauth2"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FACEBOOK_APP_ID"], ENV["FACEBOOK_SECRET"],{:image_size => 'large', secure_image_url: true}
  provider :google_oauth2, ENV["GOOGLE_APP_ID"], ENV["GOOGLE_SECRET"], { access_type: "offline", approval_prompt: ""}
  provider :twitter, ENV["TWITTER_APP_ID"], ENV["TWITTER_SECRET"] 
end
