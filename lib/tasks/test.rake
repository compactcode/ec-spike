namespace :test do
  desc 'Send a test SMS.'
  task :sms => :environment do
    Twilio::REST::Client.new.messages.create(
      from: ENV.fetch('TWILIO_NUMBER'),
      to:   '+61402066442',
      body: 'You have just received a new payment.'
    )
  end
end
