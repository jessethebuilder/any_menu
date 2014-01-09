require 'spec_helper'

describe 'The Pass Requests (order_index)' do
  let!(:store){ create :test_store }

  specify 'An unauthentiated user tries to sign in' do
    visit orders_path
    page.current_path.should == new_user_session_path
    #page.should have_content("You must be signed in as an Store User to visit that page.")
  end

  specify 'A customer user tries to visit order_index_path' do
    login(create :customer)
    visit orders_path
    page.current_path.should == root_path
    page.should have_content("You must be signed in as an Store User to visit that page.")
  end

  describe 'Signed in as :owner' do
    let(:owner){ create :owner }
    before do
      login(owner)
    end
  end

end