require 'docusign_rest'

DocusignRest.configure do |config|
  config.username       = ENV["DOCUSIGN_USERNAME"]
  config.password       = ENV["DOCUSIGN_PASSWORD"]
  config.integrator_key = ENV["DOCUSIGN_INTEGRATOR_KEY"]
  config.account_id     = ENV["DOCUSIGN_ACCOUND_ID"]
end
