FactoryGirl.define do
  factory :user do
    sequence(:name) { Faker::Name.name }
    sequence(:email) { Faker::Internet.email }
    after(:build) do |u|
      u.password_confirmation = u.password = '123456'
    end
  end
end
