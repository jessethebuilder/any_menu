require 'spec_helper'

describe 'Order completion requests' do
  let!(:store){create :test_store }
  let!(:order){ create :order }
  #
  #describe 'Special validations for order completion' do
  #  before(:each) do
  #    visit complete_order_path(order)
  #  end
  #
  #  specify 'Order must have a #contact_name or will fail validation' do
  #   # save_and_open_page
  #
  #    click_button 'Complete Order'
  #    page.current_path.should == complete_order_path(order)
  #    page.should.have_content 'contact name cannot be blank'
  #  end
  #
  #
  #  specify 'Order must have a #contact_phone or will fail validation' do
  #    click_button 'Complete Order'
  #    page.current_path.should == complete_order_path(order)
  #    page.should have_content 'contact phone cannot be blank'
  #  end
  #end #special validations

  describe 'OrderItem section' do
    before(:each) do
      5.times do
        order.order_items << create(:order_item)
      end
    end

    it 'should include the total of all order items' do
      visit complete_order_path(order)
      within('#total') do
        page.should have_text number_to_currency(order.total)
      end
    end

    it 'should include the total of tax' do
      visit complete_order_path(order)
      #save_and_open_page
      within('#tax') do
        page.should have_text number_to_currency(order.tax, :unit => '')
      end
    end

    specify 'shows the proper value for tax total on Order Complete page (real math)' do
      owner = create :owner
      login(owner)
      visit edit_store_path(store)
      fill_in 'Sales tax rate', :with => '10'
      click_button 'Update Store'

      o = create :order
      10.times do
        o.order_items << create(:order_item, :cost => 1, :quantity => 10)
      end

      visit complete_order_path(o)

      within('#tax') do
         page.should have_content('10.00')
      end
    end
  end
end