require 'spec_helper'

describe 'editing menus' do
  let(:menu){ build :menu }
  let(:store){ build :store}

  specify 'creating a menu' do
    store.save!
    visit new_menu_path
    fill_in 'Name', :with => 'Test Menu'
    click_button 'Create Menu'
    page.current_path.should == edit_menu_path(Menu.where(:name => 'Test Menu').first)
    page.should have_content 'Test Menu'
  end

  specify 'deleting a menu' do
    menu.save!
    id = menu.id
    visit edit_menu_path(menu)
    click_link 'Delete Menu'
    Menu.where(:id => id).empty?.should be_true
  end


end