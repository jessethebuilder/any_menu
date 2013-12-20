require 'spec_helper'

describe Menu do
  let(:menu){ build :menu }
  let(:menu_with_section){ create :menu_with_section }

  describe 'validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :store }
    #it{ should validate_presence_of :hours_available }
  end

  describe '#sections_not_on_this_menu' do
    it 'should return all sections that are not on the menu' do
      menu_with_section.save!
      free_section = create :section

      menu2 = create :menu
      menu_section = create :section
      menu2.sections << menu_section

      sections = menu_with_section.sections_not_on_this_menu

      sections.count.should == 2
      sections.should == [menu_section, free_section]
    end
  end
end