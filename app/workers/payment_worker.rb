class PaymentWorker
  include Sidekiq::Worker

  def perform(payload)
    data = payload.with_indifferent_access.fetch(:data)

    account_id      = data.fetch(:account_id)
    current_balance = data.fetch(:transaction).fetch(:current_balance)

    Device.includes(:accounts).where(accounts: { external_id: account_id,}, wants_notifications: true).each do |device|
      DeviceNotifier.notify_balance_change(device, current_balance)
    end
  end
end
