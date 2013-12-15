require 'spec_helper'

describe 'new owner specs' do
  let(:store){ create :store }

  specify 'going to the root before the Store is saved goes to new_store_path AFTER a Devise sign-up request' do
    visit '/'
    within('#top_nav') do
      page.should have_text('Any Menu Template')
    end

    page.current_path.should == "/users/sign_in"
    click_link 'Sign up'

    fill_in 'Email', :with => 'test@test.com'
    fill_in 'Password', :with => 'testtest'
    fill_in 'Password confirmation', :with => 'testtest'
    click_button 'Sign up'

    page.current_path.should == '/stores/new'

    User.first.user_type.should == 'owner'
    fill_in 'Store Name', :with => Faker::Company.bs
    fill_in 'Sales tax rate', :with => Random.rand(0.0..15.0)
    click_button 'Create Store'

    within('#top_nav') do
      page.should have_text(Store.first.name)
      page.should have_text("Store Tools")
    end
  end
end