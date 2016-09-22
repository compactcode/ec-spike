class DeviceNotifier
  def self.notify_balance_change(device)
    if device.phone_number.present?
      Twilio::REST::Client.new.messages.create(
        from: ENV.fetch('TWILIO_NUMBER'),
        to:   device.phone_number,
        body: 'You have just received a new payment from Centrelink.'
      )
    else
      sleep(0.1)
    end
  end
end
