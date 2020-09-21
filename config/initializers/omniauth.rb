Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_CONSUMER_KEY'], ENV['FACEBOOK_CONSUMER_SECRET']
end
