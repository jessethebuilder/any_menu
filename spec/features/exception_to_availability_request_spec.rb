require 'spec_helper'

describe 'ExceptionToAvailability requests' do
  describe 'Back button' do
    it 'should return user to the edit page that it came from (edit_store or edit_menu)' do
      store = make_store_and_login_as_owner
      visit edit_store_path(store)
      within('#hours_available') do
        click_link 'Schedule Closure'
      end
      click_link 'Back'
      page.current_path.should == edit_store_path(store)
    end
  end

  describe 'Delete Button' do
    it 'should not be on page if record is new' do
      store = make_store_and_login_as_owner
      visit edit_store_path(store)

      click_link 'Schedule Closure'
      page.should_not have_link('Delete')

      test_name = Faker::Company.bs
      fill_in 'Name', :with => test_name

      fill_in_date_time('exception_to_availability_close', Time.now + 1.day)
      fill_in_date_time('exception_to_availability_open', Time.now + 2.days)

      click_button 'Schedule Closure'

      within('#hours_available') do
        click_link test_name
      end
      click_link 'Delete'
      page.current_path.should == edit_store_path(store)
      within('#hours_available') do
        page.should_not have_content(test_name)
      end
    end
  end
end