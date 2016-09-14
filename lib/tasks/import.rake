namespace :import do
  desc 'Import a bunch of customer data.'
  task :data => :environment do
    50000.times do
      FactoryGirl.create(:account)
    end
  end

  desc 'Generate a bunch of data for existing customers.'
  task :events => :environment do
    Account.find_each do |account|
      PaymentWorker.perform_async({
        data: {
          account_id: account.external_id,
          transaction: {
            amount:          SecureRandom.random_number(10000),
            current_balance: SecureRandom.random_number(10000) + 10000
          }
        }
      })
    end
  end
end
