require 'spec_helper'

describe Store do
  let(:store){ build :store }

  describe '#dining_location_options' do
    it 'should differ depending on boolean values of store.delivers and store.dine_in' do
      store.dining_location_options.should == ['take_out']
      expect{ store.delivers = true }.to change{ store.dining_location_options.count }.by(1)
      store.dining_location_options.include?('delivery').should be_true
      expect{ store.dine_in = true }.to change{ store.dining_location_options.count }.by(1)
      store.dining_location_options.include?('dine_in').should be_true
      expect{ store.delivers = false }.to change{ store.dining_location_options.count }.by(-1)
    end
  end

  describe 'validation' do
    it{ should validate_presence_of :name }
    it{ should validate_numericality_of :sales_tax_rate }
    it{ should validate_presence_of :sales_tax_rate }
    it{ should validate_presence_of :menu_package }
    it{ should ensure_inclusion_of(:menu_package).in_array(MENU_PACKAGES) }

    it{ should validate_presences_of(:average_wait_time) }
    it{ should validate_numericallity_of :average_wait_time }
    it 'should add error if #average_wait_time is less than 1' do
      store.average_wait_time = Random.rand(-10000..0)
      store.should be_invalid
      store.errors[:average_wait_time].should include 'cannot be less than 1'
    end

    it 'should add error, before create if a Store already exists' do
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

  describe '#payment_types' do

    describe '#accepts_checks' do
      it 'should default to true' do
        s = Store.new
        s.accepts_checks.should be_true
      end
    end #accepts_checks
  end #payment_types

  #describe '#current_menu' do
  #  before(:each) do
  #    4.times.each do
  #      m = create :menu
  #      store.menus << m
  #    end
  #    store.hours_available = create(:hours_available_with_sunday)
  #    store.save!
  #  end
  #
  #  #it 'return the menu that is set to active, IF the store is open' do
  #  #  Timecop.freeze(2013, 12, 15)
  #  #  store.current_menu.should == Menu.first
  #  #end
  #
  #  #it 'return nil IF the store is closed' do
  #  #  Timecop.freeze(2013, 12, 17)
  #  #  store.current_menu.should be_nil
  #  #end
  #
  #  describe 'if menu_package is single_menu' do
  #    it 'should be the first menu created' do
  #      store.current_menu.should == Menu.first
  #    end
  #  end
  #
  #end
end