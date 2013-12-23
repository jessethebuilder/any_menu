require 'spec_helper'

describe "order_items/edit" do
  before(:each) do
    @order_item = assign(:order_item, stub_model(OrderItem,
      :user_id => 1
    ))
  end

  it "renders the edit order_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", order_item_path(@order_item), "post" do
      assert_select "input#order_item_user_id[name=?]", "order_item[user_id]"
    end
  end
end
