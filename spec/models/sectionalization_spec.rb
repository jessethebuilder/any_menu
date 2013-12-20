require 'spec_helper'

describe Sectionalization do
  let(:section){ create :section }
  let(:menu){ create :menu }

  describe 'validation' do
    specify 'a Sectionalization with the same menu_id and section_id as one that exists will RAISE AN ERROR' do
      menu.save
      section.save
      menu.sections << section
      expect{ menu.sections << section }.to raise_error
    end
  end

  specify 'it should be destroyed if the associated menu or section is destroyed' do
    menu.save!
    section.save!
    menu.sections << section
    expect{ menu.destroy }.to change{ Sectionalization.count }.by(-1)
  end

end