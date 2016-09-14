FactoryGirl.define do
  factory :device do
    customer
    uuid                { SecureRandom.uuid }
    wants_notifications { [false, true].sample }
  end
end
