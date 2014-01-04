require 'spec_helper'

describe Order do
  let(:order){ create :order }

  it{ should have_many :order_items }
  it{ should accept_nested_attributes_for :order_items}

  describe 'Validations' do
    it{ should ensure_inclusion_of(:status).in_array(Order::STATUSES) }

    it 'if delivery == true, it should check to see that NONE of the OrderItems are dont_deliver == true' do
      order.dining_location = 'delivery'
      dont_deliver_item = create(:item, :dont_deliver => true)
      order_item = create(:order_item)
      order_item.item = dont_deliver_item
      order.order_items << order_item
      order.valid?.should be_false
      order.errors.messages[:order_items].include?("#{dont_deliver_item.name} is not available for delivery.").should be_true
      order.dining_location = 'take_out'
      order.should be_valid
    end

    describe 'special validations for complete order' do
      specify 'if #status == completing, validate for #contact_name and #contact_phone' do
        order.contact_name = nil
        order.contact_phone = nil
        order.should be_valid
        order.status = 'completing'
        order.should_not be_valid
        order.errors[:contact_name].should include "contact name must be included to complete order"
        order.errors[:contact_phone].should include "contact phone number must be included to complete order"
      end
    end
  end

  describe 'Associations' do
    it{ should belong_to :user }
  end

  describe 'Calculated Values' do
    describe '#order_items_total' do
      it 'should return the total of all of the item_totals' do
        3.times do
          order.order_items << create(:order_item, :cost => 100, :quantity => 2)
        end
        order.order_items_total.should == 600
      end
    end

    describe '#tax' do
      it 'should return the total of taxes of all taxed items' do
        store = create :store, :sales_tax_rate => 10
        5.times do
          order.order_items << create(:order_item, :cost => 5, :quantity => 2)
        end
        order.tax.should == 5.0
      end
    end

    describe '#total' do
      it 'should return the total of all order_items + tax where applicable' do
        store = create :store
        3.times do
          order.order_items << create(:order_item)
        end
        order.save!
        order.total.should == order.order_items.collect{ |oi| oi.item_total + oi.tax }.reduce(:+)
      end
    end
  end

  describe '#place_order_at' do
    describe 'Special validation' do
      it 'should be invalid if time to place order is after time the store closes' do
        create :store
        #default store is always closed (each day of hours_available is set to nil)
        order = create :order
        order.place_order_at = Time.parse('12:00pm')
        order.valid?.should be_false
        order.errors[:place_order_at].should include('is after we close.')
      end
    end
  end

end