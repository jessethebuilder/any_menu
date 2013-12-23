require 'spec_helper'

describe "order_items/new" do
  before(:each) do
    assign(:order_item, stub_model(OrderItem,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new order_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", order_items_path, "post" do
      assert_select "input#order_item_user_id[name=?]", "order_item[user_id]"
    end
  end
end
