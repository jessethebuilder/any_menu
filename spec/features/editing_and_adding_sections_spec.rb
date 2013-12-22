require 'spec_helper'

describe 'editing and adding sections' do
  let(:section){ create :section }
  let(:menu){ create :menu }

  describe 'editing a section' do
    before(:each) do
      menu.save!
      menu.sections << section
    end

    specify 'editing from edit_section returns to sections_path' do
      visit edit_section_path(section)
      fill_in 'Name', :with => 'Test Section'
      click_button 'Update Section'
      page.should have_content 'Test Section was successfully updated'
      page.current_path.should == sections_path
    end

    specify 'editing from edit_menu_section returns to menu' do
      visit edit_menu_section_path(menu, section)
      fill_in 'Name', :with => 'Test Section'
      click_button 'Update Section'
      page.should have_content 'Test Section was successfully updated'
      page.current_path.should == edit_menu_path(menu)
    end
  end

  describe 'adding section from edit_menu' do
    specify 'adding a section' do
      menu.save!
      visit edit_menu_path(menu)
      within '#section_list' do
        click_link 'Add Section'
      end
      fill_in 'Name', :with => 'Test Section'
      click_button 'Create Section'

      page.should have_content 'Edit Section: Test Section'

      click_link "(return to #{menu.name})"
      within '#section_list' do
        page.should have_content 'Test Section'
      end
      s = Section.where(:name => 'Test Section').last
      s.menus.include?(menu).should be_true
    end

    specify 'A Section with an error should still save proper Sectionalization' do
      visit new_menu_section_path(menu)
      fill_in 'Description', :with => "Text"
      click_button 'Create Section' #adds name validation error
      find_field('Description').value.should eq 'Text'

      fill_in 'Name', :with => 'Name'
      click_button 'Create Section'
      sec = Sectionalization.last
      sec.menu_id.should == menu.id
      sec.section_id.should == Section.last.id
    end
  end

  describe 'deleting a section' do
    specify 'deleting from menu_section_edit' do
      menu.sections << section
      visit edit_section_path(section, menu)
      expect{ click_link "Delete Section" }.to change{ Section.count }.by(-1)
    end
  end

  describe 'tracking the menu through routes' do
    let!(:owner){ login_owner }
    let(:menu){ create :menu_with_section }

    specify 'if a section is created outside of the context of a menu, it stays in its own path' do
      visit new_section_path
      fill_in 'Name', :with => Faker::Commerce.color
      click_button 'Create Section'

      section = Section.last
      page.current_path.should == edit_section_path(section)
    end

    specify 'if a section is saved from a menu, it keep the menu in path when it redirects to edit after save' do
      store.menus << menu
      visit new_menu_section_path(menu)
      fill_in 'Name', :with => Faker::Commerce.color
      click_button 'Create Section'

      section = Section.last
      page.current_path.should == edit_menu_section_path(menu, section)
    end

    specify 'if a section is deleted from a menu, return to edit_menu' do
      menu.save!
      store.menus << menu
      section = Section.last
      visit edit_section_path(section)
      click_link 'Delete Section'
      #section.destroyed?.should be_true
      page.current_path.should == sections_path
    end
  end

  describe 'Adding existing sections to menus' do
    before(:each) do
      menu.save!
      menu.sections << section
      create :section, :name => 'free section'

      menu2 = create :menu
      section2 = create :section, :name => 'section on other menu'
      menu2.sections << section2

      visit edit_menu_path(menu)
      click_link 'Add Section'
    end

    specify 'section_edit from menu should show a list of all sections NOT on current menu' do
      page.should have_link 'free section'
      page.should have_link 'section on other menu'
    end

    specify 'clicking link should add a section and return to edit_menu' do
      click_link 'free section'
      page.current_path.should == edit_menu_path(menu)
      menu.sections.last.should == Section.where(:name => 'free section').first
      click_link 'Add Section'
      expect{ click_link 'section on other menu' }.to change{ Sectionalization.count }.by(1)
    end
  end
end