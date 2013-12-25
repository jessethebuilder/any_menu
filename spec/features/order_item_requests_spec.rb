#require 'spec_helper'
#
#describe 'Order Item Requests' do
#  let!(:store){ create :test_store }
#
#  specify 'Price is based on WHEN MENU IS SERVED to user. Not when the OrderItem is created' do
#    test_item = Menu.first.sections.first.items.first
#    test_cost = test_item.cost
#
#    #this is done through a hidden field when on menu_show (actually item/_show_on_menu)
#    visit menu_path(Menu.first)
#
#    test_item.cost = 500000
#    test_item.save!
#    within("#item_#{test_item.id}") do
#      click_button 'Add to Order'
#    end
#
#    test_order_item = OrderItem.last
#    test_order_item.price.should_not == 500000
#    test_order_item.price.should == test_cost
#  end
#end