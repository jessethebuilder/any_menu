require 'spec_helper'

describe Section do
  let(:section){ build :section }
  let(:menu){ build :menu }

  describe 'validations' do
    it{ should validate_presence_of :name }
  end

  specify 'it should create a new Sectionalization and save it if @id_for_menu is not nil at the time of save' do
    menu.save!
    section.id_for_menu = menu.id
    expect{ section.save! }.to change{ Sectionalization.count }.by(1)
    sec = Sectionalization.last
    sec.section_id.should == section.id
    sec.menu_id.should == menu.id
  end

  specify 'it should NOT create a new Sectionalization if no #id_for_menu is given' do
    menu.save!
    expect{ section.save! }.to_not change{ Sectionalization.count }
    Sectionalization.where(:section_id => section.id).empty?.should be_true
  end

  describe '#sectionalization(menu)' do
    it 'should return the sectionalization to between self and menu param' do
      menu.save!
      menu.sections << section
      section.sectionalization(menu).should == Sectionalization.last
    end
  end
end