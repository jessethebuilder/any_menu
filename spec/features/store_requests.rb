require 'spec_helper'

describe 'Store request specs' do
  #let(:owner){ login_owner }
  let(:owner){ :owner }
  describe 'Menu Packages' do
    specify 'A new store should prompt for a menu package in _form, but a saved store will not.' do
      visit new_store_path
      page.should have_field('Menu Package')
      store = create :store
      visit edit_store_path(store)
      page.should_not have_field('Menu Package')
    end
  end
end
