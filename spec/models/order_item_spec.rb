require 'spec_helper'

describe OrderItem do
  let(:oi){ build :order_item }
  specify{ oi.should be_valid }

  describe 'Validations' do
    it{ should validate_numericality_of :quantity }
    it{ should validate_presence_of :item}
    #it{ should validate_presence_of :order }
    it{ should validate_presence_of :cost }
    it{ should validate_numericality_of :cost }
    it 'should validate price is a positive number' do
      oi.cost = -1
      oi.should_not be_valid
      oi.cost = 0
      oi.should be_valid
    end
  end

  describe 'Associations' do
    it{ should belong_to :item }
    it{ should belong_to :order }
  end

  specify 'if order is saved without a quantity is set to 1' do
    oi.quantity = nil
    oi.save!
    oi.quantity.should == 1
  end

  describe 'Calculation methods' do
    describe '#item_total' do
      it 'should return the cost of item times quantity' do
        oi.quantity = 40
        #remember, OrderItem saves its own cost.
        oi.cost = 1
        oi.item_total.should == 40
        oi.cost = 2
        oi.item_total.should == 80
      end
    end

    describe '#tax_total' do
      let!(:store){ create :store }

      it 'should return the total tax due on the item' do
        oi.tax.should == oi.item_total * (0.01 * store.sales_tax_rate)
      end

      specify 'math proof' do
        store.sales_tax_rate = 10
        store.save!
        oi = create :order_item, :quantity => 3, :cost => 10
        oi.tax.should == 3.0
      end

      it 'should return 0 for items if #tax_exempt == true' do
        oi = create :order_item
        oi.item.tax_exempt = true
        oi.tax.should == 0
      end
    end

  end


end
