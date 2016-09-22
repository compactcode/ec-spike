class PaymentWorker
  include Sidekiq::Worker

  class NotifiableCache
    CACHE_KEY = 'notifiable'

    def self.refresh!
      Sidekiq.redis do |connection|
        connection.multi do
          connection.del(CACHE_KEY)
          connection.sadd(
            CACHE_KEY,
            Account.joins(:devices).where(devices: { wants_notifications: true }).distinct.pluck(:external_id)
          )
        end
      end
    end

    def self.includes_account?(account_id)
      Sidekiq.redis do |connection|
        connection.sismember(CACHE_KEY, account_id)
      end
    end
  end

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
      @account_id = @payload.with_indifferent_access.fetch(:data).fetch(:account_id)
    end

    def filter
      if NotifiableCache.includes_account?(@account_id)
        @filtered = Device.includes(:accounts).where(accounts: { external_id: @account_id,}, wants_notifications: true).to_a
      else
        @filtered = []
      end
    end

    def notify
      @filtered.each do |device|
        DeviceNotifier.notify_balance_change(device)
      end
    end
  end
end
