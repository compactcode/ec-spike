class PaymentWorker
  include Sidekiq::Worker

  def perform(payload)
    Steps.new(payload).execute
  end

  class Steps
    def initialize(payload)
      @payload = payload
    end

    def execute
      extract
      Benchmark.bm do |bm|
        bm.report('filter') { filter }
      end
      notify
    end

    private

    def extract
      data = @payload.with_indifferent_access.fetch(:data)

      @account_id      = data.fetch(:account_id)
      @current_balance = data.fetch(:transaction).fetch(:current_balance)
    end

    def filter
      @filtered = Device.includes(:accounts).where(accounts: { external_id: @account_id,}, wants_notifications: true).to_a
    end

    def notify
      @filtered.each do |device|
        DeviceNotifier.notify_balance_change(device, @current_balance)
      end
    end
  end
end
