require 'spec_helper'

describe Menu do
  let(:menu){ build :menu }

  describe 'validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :store }
    it{ should validate_presence_of :hours_available }
  end

  specify "" do
    menu.should be_valid
  end
end