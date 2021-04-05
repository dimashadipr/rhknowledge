# frozen_string_literal: true

# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key   = ENV['RECAPTCHA_SITE_KEY']
  config.secret_key = ENV['RECAPTCHA_SECRET_KEY']
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://unsullied.lvh.me:3000'
end
