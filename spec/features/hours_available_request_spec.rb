#
#
#
##Uncomment and run once hours_available bug is solved for Heroku.
#
#require 'spec_helper'
#
#describe 'Hours Available Requests' do
#
#  specify 'adding an ExceptionToAvailability' do
#    store = make_store_and_login_as_owner
#
#    visit edit_store_path(store)
#    within('#hours_available') do
#      click_link 'Schedule Closure'
#    end
#    fill_in 'Name', :with => Faker::Commerce.color
#    expect{ click_button 'Schedule Closure' }.to change{ ExceptionToAvailability.count }.by(1)
#    #should redirect back to menu or store that was being edited
#    page.current_path.should == edit_store_path(store)
#    new_exception = ExceptionToAvailability.last
#    within '#hours_available' do
#      page.should have_content(new_exception.name)
#    end
#  end
#
#  specify 'should save to proper HoursAvailable, even it errors the first time' do
#    store = make_store_and_login_as_owner
#    visit edit_store_path(store)
#    within('#hours_available') do
#      click_link 'Schedule Closure'
#    end
#
#    click_button 'Schedule Closure'
#    #doesn't save because of validation errors
#    test_name = Faker::Commerce.color
#    fill_in 'Name', :with => test_name
#    click_button 'Schedule Closure'
#    exception = ExceptionToAvailability.where(:name => test_name).first
#    exception.hours_available.should == store.hours_available
#  end
#end
#
