FactoryGirl.define do
  factory :school do
    name { Faker::Company.name }
    address
  end
end