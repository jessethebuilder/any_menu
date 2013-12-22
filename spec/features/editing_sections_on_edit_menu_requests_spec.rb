require 'spec_helper'

#todo other specs belong here.

describe 'edits to Sections from edit_menu' do
  let!(:menu){ create :menu }

  before(:each) do
    5.times do
      menu.sections << create(:section)
    end
  end

  describe 'moving sections up and down the menu' do
    it 'should raise the order of a Section when the UP arrow is pressed' do
     # visit menu_path(menu)
      pending 'edits to sectionson menu'
    end
  end

  describe 'removing a section from the menu' do

    specify 'removing a section with the remove link' do
      visit edit_menu_path(menu)
      section_name = Section.first.name
      within ('#section_list') do
        links = page.all('a', :text => 'remove')
        links.count.should == 5
        links[0].click
      end
      page.current_path.should == edit_menu_path(menu)
      within ('#section_list') do
        page.should_not have_text(section_name)
        links = page.all('a', :text => 'remove')
        links.count.should == 4
      end
    end

  end
end