#require 'spec_helper'
#
#describe 'Ordering', :js => true do
#  let!(:store){ create :test_store }
#  let(:test_item){ Menu.first.sections.first.items.first }
#
#  describe 'Ordering as an unknown user' do
#    before(:each) do
#      visit menu_path(Menu.first)
#    end
#
#    specify 'an order should be created, since one does not exist' do
#      within("#item_#{test_item.id}") do
#        expect{ click_button 'Add to Order' }.to change{ Order.count }.by(1)
#      end
#    end
#
#    specify 'new order should have new order item on it' do
#      within("#item_#{test_item.id}") do
#        click_button 'Add to Order'
#      end
#      order = Order.last
#      order.order_item.last.item.should == test_item
#    end
#
#    specify 'it should not create a new order, once one has been created for this session. New "Add to Order" click
#              should add new OrderItems' do
#      within("#item_#{test_item.id}") do
#        click_button 'Add to Order'
#      end
#      order = Order.last
#      within("#item_#{test_item}") do
#        expect{ click_button 'Add to Order' }.to change{ order.order_items.count }.by(1)
#      end
#      Order.last.should == order
#    end
#  end
#
#  describe 'Ordering as a known user' do
#
#  end
#end