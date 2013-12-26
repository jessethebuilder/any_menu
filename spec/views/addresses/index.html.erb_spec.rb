require 'spec_helper'

describe "addresses/index" do
  before(:each) do
    assign(:addresses, [
      stub_model(Address,
        :name => "Name",
        :street => "Street",
        :street2 => "Street2",
        :apartment_number => "Apartment Number",
        :city => "City",
        :state => "State",
        :zip => "Zip"
      ),
      stub_model(Address,
        :name => "Name",
        :street => "Street",
        :street2 => "Street2",
        :apartment_number => "Apartment Number",
        :city => "City",
        :state => "State",
        :zip => "Zip"
      )
    ])
  end

  it "renders a list of addresses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => "Street2".to_s, :count => 2
    assert_select "tr>td", :text => "Apartment Number".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
  end
end
