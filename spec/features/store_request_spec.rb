require 'spec_helper'

describe 'Store request specs' do
  let(:store){ create :test_store }
  let(:owner){ create :owner }
  before(:each) do
    login(owner)
  end

  describe 'Menu Packages' do

  end

  describe 'Editing things' do
    specify 'if I click dine_in, dine_in is added to store.dining_locations and given as an option at order_complete' do
      visit edit_store(store)
      page.check('Dine in available')
      click_button 'Update Store'
      store.dining_locations.should include('dine_in')

      #below requires :js
      #within('#top_nav') do
      #  #when this spec was written, there was no logic for logged in user.
      #  click_link 'Logout'
      #end
      #
      #visit menu_path(store.current_menu)
      #click_link 'Add to Order'
      #
    end
  end
end
