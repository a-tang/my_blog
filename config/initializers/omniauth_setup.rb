Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,
  ENV["twitter_consumer_key"],
  ENV['twitter_consumer_secret']
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
  ENV['facebook_application_id'],
  ENV['facebook_secret_app_key']
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
  ENV['google_client_id'],
  ENV['google_client_secret_key']
end
