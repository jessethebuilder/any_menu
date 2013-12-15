require 'spec_helper'

describe Sectionalization do
  let!(:section){ create :section }
  let!(:menu){ create :menu }

  describe 'validation' do
    specify 'a Sectionalization with the same menu_id and section_id as one that exists will RAISE AN ERROR' do
      menu.sections << section
      expect{ menu.sections << section }.to raise_error
    end
  end
end