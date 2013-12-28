require 'spec_helper'

describe Order do
  let(:order){ create :order }

  it{ should have_many :order_items }
  it{ should accept_nested_attributes_for :order_items}

  describe 'Validations' do
    it{ should validate_presence_of :contact_phone }
    it{ should validate_presence_of :contact_name}

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
  end

  describe 'Associations' do
    it{ should belong_to :user }
  end

end