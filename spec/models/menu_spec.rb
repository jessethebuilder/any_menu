require 'spec_helper'

describe Menu do
  let(:menu){ build :menu }
  let(:menu_with_section){ create :menu_with_section }

  describe 'validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :store }
    #it{ should validate_presence_of :hours_available }
  end

  describe '#activate' do
    specify "if activate is called on a menu, all other menus' #active attribute gets set to false" do
      #todo hours available
    end
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

  describe 'section_order' do
    before(:each) do
      menu.save!
      3.times do
        menu.sections << create(:section)
      end
    end

    it 'should have 3 elements' do
      menu.section_order.count.should == 3
    end

    it 'should be an Array' do
      menu.section_order.class.should == Array
    end

    it 'should add the id of any section added to menu at the end of the Array' do
      new_section = create :section
      menu.sections << new_section
      menu.section_order.last.should == new_section.to_param
    end

    it 'should remove section_id from section_order when section is removed' do
      new_section = create :section
      menu.sections << new_section
      expect{ menu.sections.delete(new_section).to change{ menu.section_order.count }.by(-1) }
    end

    describe '#move_section(section, velocity)' do
      specify 'it expects 2 parameters: a section and a positive or negative integer' do
        test_section = Section.first
        menu.move_section(test_section, 1)
        menu.section_order[1].should == test_section.to_param

        test_section2 = Section.last
        menu.move_section(test_section2, -1)
        menu.section_order[1].should == test_section2.to_param
      end

      specify 'velocities that outside of #section_order array bounds loop around' do
        test_section = Section.first
        menu.move_section(test_section, -1)
        menu.section_order.last.should == test_section

        menu.move_section(test_section, 1)
        menu.section_order.first.should == test_section
      end

      #it 'should throw an error if the move_modifier tries to place section out of bounds' do
      #  expect{ menu.move_section(Section.first, 20) }.to raise_error
      #  expect{ menu.move_section(Section.first, -1) }.to raise_error
      #end
    end

    describe 'ordered_sections' do

      it 'should order the sections according to attr section_order (described below)' do
        s1 = menu.sections.first
        s2 = menu.sections.last
        menu.ordered_sections.first.should == s1
        menu.ordered_sections.last.should ==s2
        menu.move_section(s1, 2)
        menu.ordered_sections.last.should == s1
        menu.move_section(s2, -1)
        menu.ordered_sections.first.should == s2
      end
    end
  end #describe #section_order

end