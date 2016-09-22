FactoryGirl.define do
  factory :account do
    customer
    external_id { SecureRandom.hex }
    balance     { SecureRandom.random_number(1000) }

    trait :with_sms_device do
      transient do
        phone_number nil
      end

      customer do
        create(:customer, :with_sms_device, phone_number: phone_number)
      end
    end

    trait :with_ios_devices do
      association :customer, :with_ios_devices
    end
  end
end
