require 'spec_helper'

describe Store do
  let(:store){ build :store }

  it{ should validate_presence_of :name }

  it{ should validate_numericality_of :sales_tax_rate => {:greater_than_or_equal_to => 0} }


  describe 'validation' do
    it 'should raise error, before create if a Store already exists' do
      store.save
      store2 = build :store
      expect{ store2.save! }.to raise_error(/Only 1 Store can exist/)
    end


  end
end