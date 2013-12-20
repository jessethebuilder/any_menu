require 'spec_helper'

describe Section do
  let(:section){ build :section }
  let(:menu){ build :menu }

  describe 'validations' do
    it{ should validate_presence_of :name }
  end

  describe '#sectionalization(menu)' do
    it 'should return the sectionalization to between self and menu param' do
      menu.save!
      menu.sections << section
      section.sectionalization(menu).should == Sectionalization.last
    end
  end



end