include ApplicationHelper

FactoryGirl.define do
  sequence(:email){ |i| "test#{i}@test.com"}
  sequence(:name){ |i| "#{Faker::Company.name}_#{i}"}

  factory :order do

    factory :order_with_order_items do

      factory :complete_order do
        contact_phone Faker::PhoneNumber.phone_number
        contact_name Faker::Name.name
      end

      ignore do
        order_item_count 10
      end
      after(:build) do |order, evaluator|
        evaluator.order_item_count.times do
          order.order_items << create(:order_item)
        end
      end
    end
  end

  factory :order_item do
    order
    item
    cost Random.rand(0..200.0)
    quantity Random.rand(1..30)
  end

  factory :hours_available do
    factory :hours_available_with_sunday do
      sunday_open "8:00AM"
      sunday_close "8:00PM"
    end

    factory :twenty4_hours_available do
      monday_open "12:00AM"
      monday_close  "12:00AM"
      tuesday_open  "12:00AM"
      tuesday_close  "12:00AM"
      wednesday_open  "12:00AM"
      wednesday_close  "12:00AM"
      thursday_open  "12:00AM"
      thursday_close  "12:00AM"
      friday_open  "12:00AM"
      friday_close  "12:00AM"
      saturday_open  "12:00AM"
      saturday_close  "12:00AM"
      sunday_open  "12:00AM"
      sunday_close  "12:00AM"
    end
  end

  factory :exception_to_availability do
    hours_available
    name
    close Time.now
    open Time.now + 1.day
  end

  factory :store do
    name
    sales_tax_rate Random.rand(0..15)
    menu_package MENU_PACKAGES.sample

    after(:build) do |s|
      s.hours_available = build(:hours_available)
    end

    factory :twenty4_hour_store do
      after(:build) do |s|
        s.hours_available = build(:twenty4_hours_available)
      end

      factory :test_store do
        after(:create) do |s|
          menu = build :test_menu
          s.menus << menu
        end
      end
    end

    #factory :store_with_owner do
    #  after(:build) do |o|
    #    o.users << build(:owner)
    #  end
    #end
  end #end store

  factory :menu do
    name
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

    factory :test_menu do
      after(:build) do |m|
        Random.rand(3..10).times do
          m.sections << build(:test_section)
        end
      end
    end
  end

  factory :item do
    name
    section
    cost Random.rand(0.0..100.0)
  end

  factory :section do
    name

    factory :test_section do
      after(:build) do |s|
        Random.rand(3..15).times do
          s.items << create(:item)
        end
      end
    end
  end

  factory :user do
    email
    password 'testtest'
    user_type USER_TYPES.sample

    factory :store_user do
      user_type 'store_user'
    end

    factory :customer do
      user_type 'customer'
    end

    factory :owner do
      user_type 'owner'
    end
  end
end