FactoryGirl.define do
  factory :account do
    customer
    external_id { SecureRandom.hex }
    balance     { SecureRandom.random_number(1000) }
  end
end
