FactoryGirl.define do
  factory :team do
    name { Faker::Company.name }
    sport { Faker::Company.name }
  end
end