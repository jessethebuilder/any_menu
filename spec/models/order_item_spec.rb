require 'spec_helper'

describe OrderItem do
  let(:oi){ build :order_item }
  specify{ oi.should be_valid }

  describe 'Validations' do
    it{ should validate_numericality_of :quantity }
    it{ should validate_presence_of :item}
    it{ should validate_presence_of :order }
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
    oi.quantity.should be_nil
    oi.save!
    oi.quantity.should == 1
  end

  describe 'Calculation methods' do
    specify '#item_total should return the cost of item times quantity' do
      oi.quantity = 40
      #remember, OrderItem saves its own cost.
      oi.cost = 1
      oi.item_total.should == 40
      oi.cost = 2
      oi.item_total.should == 80
    end
  end


end
