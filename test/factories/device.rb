FactoryGirl.define do
  factory :device do
    customer
    wants_notifications { [false, true].sample }
  end
end
