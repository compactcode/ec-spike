namespace :import do
  desc 'Generate 50k test customers.'
  task :customers, [:sms_devices] => :environment do |t, args|
    sms_devices = *args
    sms_devices = sms_devices.map(&:strip).uniq.map do |sms_device|
      "+61" + sms_device[1..-1]
    end

    (25000 - sms_devices.size).times do |i|
      FactoryGirl.create(:account, :with_ios_devices)
    end

    sms_devices.each do |sms_device|
      FactoryGirl.create(:account, :with_sms_device, phone_number: sms_device)
    end
  end

  desc 'Generate events for each customer in a random order.'
  task :events => :environment do
    Account.pluck(:external_id).shuffle.each do |external_id|
      PaymentWorker.perform_async({
        data: {
          account_id: external_id,
          transaction: {
            amount:          SecureRandom.random_number(10000),
            current_balance: SecureRandom.random_number(10000) + 10000
          }
        }
      })
    end
  end

  desc 'Generate the sidekiq cache of notifiable accounts.'
  task :cache => :environment do
    PaymentWorker::NotifiableCache.refresh!
  end
end
