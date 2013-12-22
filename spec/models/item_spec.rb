require 'spec_helper'

describe Item do
  let(:item){ create :item }

  specify {item.should be_valid}

  describe 'Validations' do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :cost }
    it{ should validate_numericality_of :cost }
    it 'should validate that #cost is greater than 0' do
      item.cost = -1
      item.should_not be_valid
      item.errors[:cost].include?("must be greater than or equal to 0").should be_true
    end
    it{ should validate_presence_of :section }
  end
end