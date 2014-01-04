require 'spec_helper'

describe 'Hours Available Requests' do

  describe 'Closing a day' do
    let!(:store){ create :test_store }
    specify 'Clicking close next to #day_open closes the store for that day' do
      login_owner
      visit edit_store_path(store)
      within('#hours_available') do
        find 'close'
      end
    end

  end

  specify 'Adding an ExceptionToAvailability' do
    store = make_store_and_login_as_owner

    visit edit_store_path(store)
    within('#hours_available') do
      click_link 'Schedule Closure'
    end
    fill_in 'Name', :with => Faker::Commerce.color

    fill_in_date_time('exception_to_availability_close', Time.now + 1.day)
    fill_in_date_time('exception_to_availability_open', Time.now + 2.days)

    #expect{ click_button 'Schedule Closure' }.to change{ ExceptionToAvailability.count }.by(1)
    click_button "Schedule Closure"

    #should redirect back to menu or store that was being edited
    page.current_path.should == edit_store_path(store)
    new_exception = ExceptionToAvailability.last
    within '#hours_available' do
      page.should have_content(new_exception.name)
    end
  end

  specify 'should save to proper HoursAvailable, even it errors the first time' do
    store = make_store_and_login_as_owner
    visit edit_store_path(store)
    within('#hours_available') do
      click_link 'Schedule Closure'
    end

    click_button 'Schedule Closure'
    #doesn't save because of validation errors
    test_name = Faker::Commerce.color
    fill_in 'Name', :with => test_name


    fill_in_date_time('exception_to_availability_close', Time.now + 1.day)
    fill_in_date_time('exception_to_availability_open', Time.now + 2.days)

    click_button 'Schedule Closure'
    exception = ExceptionToAvailability.where(:name => test_name).first
    exception.hours_available.should == store.hours_available
  end
end

