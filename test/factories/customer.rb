FactoryGirl.define do
  factory :customer do
    trait :with_sms_device do
      transient do
        phone_number 1
      end

      after(:create) do |customer, evaluator|
        create(:device, customer: customer, wants_notifications: true, phone_number: evaluator.phone_number)
      end
    end

    trait :with_ios_devices do
      after(:create) do |customer|
        create_list(:device, SecureRandom.random_number(2), customer: customer)
      end
    end
  end
end
