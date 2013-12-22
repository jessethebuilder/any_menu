require 'spec_helper'

describe Store do
  let(:store){ build :store }

  describe 'validation' do
    it{ should validate_presence_of :name }
    it{ should validate_numericality_of :sales_tax_rate }
    it{ should validate_presence_of :sales_tax_rate }
    it{ should validate_presence_of :menu_package }
    it{ should ensure_inclusion_of(:menu_package).in_array(MENU_PACKAGES) }

    it 'should raise error, before create if a Store already exists' do
      store.save
      store2 = build :store
      expect{ store2.save! }.to raise_error(/Only 1 Store can exist/)
    end

    it 'should add a validation error if #sales_tax_rate is less than 0' do
      store.sales_tax_rate = -1
      store.valid?.should be_false
      store.errors[:sales_tax_rate].include?("must be greater than or equal to 0").should be_true
    end


  end

  describe '#current_menu' do
    before(:each) do
      4.times.each do
        m = create :menu
        store.menus << m
      end
      menu = Menu.first
      menu.active = true
      menu.save!

      store.hours_available = create(:hours_with_sunday)
      store.save!
    end

    it 'return the menu that is set to active, IF the store is open' do
      Timecop.freeze(2013, 12, 15)
      store.current_menu.should == Menu.first
    end

    it 'return nil IF the store is closed' do
      Timecop.freeze(2013, 12, 17)
      store.current_menu.should be_nil
    end

  end
end