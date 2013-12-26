require 'spec_helper'

describe "addresses/show" do
  before(:each) do
    @address = assign(:address, stub_model(Address,
      :name => "Name",
      :street => "Street",
      :street2 => "Street2",
      :apartment_number => "Apartment Number",
      :city => "City",
      :state => "State",
      :zip => "Zip"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Street/)
    rendered.should match(/Street2/)
    rendered.should match(/Apartment Number/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(/Zip/)
  end
end
