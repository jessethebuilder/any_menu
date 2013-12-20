require 'spec_helper'

describe 'Requests related to store.menu_package' do

  describe 'single_menu' do
    #The only menu package available is single_menu
    specify 'hours_available form should not be on menu _form' do
      login_owner
      Store.first.update(:menu_package => 'single_menu')
      visit new_menu_path
      page.should_not have_css('#hours_available')


    end
  end
end
