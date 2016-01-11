FactoryGirl.define do
  factory :act do
    sequence(:title) { Faker::Name.title }
    sequence(:points) { rand(-20..20) }
    user
  end
end
