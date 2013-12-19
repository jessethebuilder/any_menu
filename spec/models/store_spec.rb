require 'spec_helper'

describe Store do
  let(:store){ build :store }

  describe 'validation' do
    it{ should validate_presence_of :name }
    it{ should validate_numericality_of :sales_tax_rate }
    it{ should validate_presence_of :menu_package }
    it{ should ensure_inclusion_of(:menu_package).in_array(MENU_PACKAGES) }

    it 'should raise error, before create if a Store already exists' do
      store.save
      store2 = build :store
      expect{ store2.save! }.to raise_error(/Only 1 Store can exist/)
    end
  end
end