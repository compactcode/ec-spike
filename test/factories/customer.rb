FactoryGirl.define do
  factory :customer do
    after(:create) do |customer|
      create_list(:device, SecureRandom.random_number(2), customer: customer)
    end
  end
end
