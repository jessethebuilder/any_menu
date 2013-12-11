include ApplicationHelper

FactoryGirl.define do
  sequence(:email){ |i| "test#{i}@test.com"}

  factory :store do
    name Faker::Company.bs
  end

  factory :user do
    email
    password 'testtest'
    user_type USER_TYPES.sample

    factory :owner do
      user_type :owner
    end
  end
end