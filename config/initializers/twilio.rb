Twilio.configure do |config|
  config.account_sid = ENV.fetch('TWILIO_SID')
  config.auth_token  = ENV.fetch('TWILIO_TOKEN')
end
