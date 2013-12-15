require 'spec_helper'

describe 'editing and adding sections' do
  let(:section){ create :section }
  let(:menu){ create :menu }

  describe 'adding section from edit_menu' do
    specify 'adding a section' do
      menu.save!
      visit edit_menu_path(menu)
      within '#section_list' do
        click_link 'Add Section'
      end
      fill_in 'Name', :with => 'Test Section'
      click_button 'Create Section'
      within '#section_list' do
        page.should have_content 'Test Section'
      end
      s = Section.where(:name => 'Test Section').last
      s.menu.should == menu
    end

    specify 'A Section with an error should still save proper Sectionalization (this is done through
             after_save filter and a hidden field in sections/form' do
      menu.save!
      visit new_menu_section_path(menu)
      fill_in 'Description', :with => "Text"
      click_link 'Add Section' #adds name validation error
      find_field('Description').value.should eq 'Text'

      fill_in 'Name', :with => 'Name'
      click_link 'Add Section'
      sec = Sectionalization.last
      sec.menu_id.should == menu.id
      sec.section_id.should == Section.last.id
    end
  end

  describe 'deleting a section' do
    specify 'deleting from section_edit' do
      visit edit_section_path(section)
      click_link "Delete Section"
      section.destroyed?.should be_true
    end
  end

  describe 'removing a section from a menu' do
    specify 'removing a section from menu_edit' do
      menu.save!
      menu.sections << section
      Sectionalization.where(:menu_id => menu.id).where(:section_id => section.id).empty?.should be_false

      visit edit_menu_path(menu)
      within('#section_list') do
        click_link 'remove'
      end

      Sectionalization.where(:menu_id => menu.id).where(:section_id => section.id).empty?.should be_true
      section.destroyed?.should be_false
    end
  end
end