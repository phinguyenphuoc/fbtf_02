OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
 provider :facebook, ENV['fb_app_id'], ENV['fb_app_secret'], {scope: "public_profile", info_fields: "email,name"}
end
