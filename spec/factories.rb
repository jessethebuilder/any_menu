include ApplicationHelper

FactoryGirl.define do
  sequence(:email){ |i| "test#{i}@test.com"}

  factory :hours_available do
    factory :hours_available_with_sunday do
      sunday_open "8:00AM"
      sunday_close "8:00PM"
    end
  end

  factory :exception_to_availability do
    hours_available
    name Faker::Commerce.color
  end

  factory :store do
    name Faker::Company.bs
    sales_tax_rate Random.rand(0.0..15.0)
    hours_available
    menu_package MENU_PACKAGES.sample

    factory :store_with_owner do
      after(:build) do |o|
        o.users << build(:owner)
      end
    end
  end

  factory :menu do
    name Faker::Company.bs
    after(:build)do |o|
      o.store = build :store
      #o.hours_available = build :hours_available
    end

    factory :menu_with_section do
      after(:create) do |menu|
        section = create(:section)
        menu.sections << section
      end
    end


  end

  factory :section do
    name Faker::Company.bs
  end



  factory :user do
    email
    password 'testtest'
    user_type USER_TYPES.sample

    factory :owner do
      user_type 'owner'

      factory :owner_with_store do
        after(:build) do |o|
          store = create :store
          store.users << o
        end
      end
    end
  end
end