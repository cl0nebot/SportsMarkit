FactoryGirl.define do
  factory :address do
    street_1 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    postcode { Faker::Address.postcode }
  end
end