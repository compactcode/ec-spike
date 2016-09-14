class DeviceNotifier
  def self.logger
    @@logger ||= Logger.new("#{Rails.root}/log/payment.log")
  end

  def self.notify_balance_change(device, current_balance)
    logger.info("Sending push for #{device.uuid} with #{current_balance}")
    sleep(0.2)
  end
end
