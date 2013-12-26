require 'spec_helper'

describe "addresses/edit" do
  before(:each) do
    @address = assign(:address, stub_model(Address,
      :name => "MyString",
      :street => "MyString",
      :street2 => "MyString",
      :apartment_number => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString"
    ))
  end

  it "renders the edit address form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", address_path(@address), "post" do
      assert_select "input#address_name[name=?]", "address[name]"
      assert_select "input#address_street[name=?]", "address[street]"
      assert_select "input#address_street2[name=?]", "address[street2]"
      assert_select "input#address_apartment_number[name=?]", "address[apartment_number]"
      assert_select "input#address_city[name=?]", "address[city]"
      assert_select "input#address_state[name=?]", "address[state]"
      assert_select "input#address_zip[name=?]", "address[zip]"
    end
  end
end
