require 'spec_helper'

describe 'Visiting the Root' do
  let(:store){ build :twenty4_hour_store }
  let(:menu){ build :menu }
  let(:owner){ build :owner }
  let(:store_user){ build :store_user }
  let(:customer){ build :customer }

  describe 'The first visit (no registered users or owners' do
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
      #todo hours available

      within('#top_nav') do
        page.should have_link(Store.first.name)
      end
    end


    describe 'Visiting page after store creation' do
      before(:each) do
        store.menus << menu
        store.users << [owner, customer, store_user]
        store.save
      end

      describe 'Visiting as an owner' do
        before(:each) do
          login(owner)
          visit '/'
        end

        specify 'root path should lead to edit_store' do
          page.current_path.should == edit_store_path(store)
        end

        specify 'top_nav should have Store Tools for owner' do
          within('#top_nav') do
            page.should have_text("Store Tools")
          end
        end
      end # owner

      describe 'Visiting root as a customer' do
        before(:each) do
          login(customer)
          visit '/'
        end

        specify 'root should be menu_path(Store.current_menu)' do
          page.current_path.should == menu_path(store.current_menu)
        end

        specify 'page should not have Store Tools in the top_nav' do
          within('#top_nav') do
            page.should_not have_content 'Store Tools'
          end
        end

      end # customer

      describe 'visiting root as a store_user' do
        before(:each) do
          login(store_user)
          visit '/'
        end

        specify 'root should be edit_store' do
          page.current_path.should == edit_store_path(store)
        end

        specify 'nav_bar should have Store Tools' do
          within('#top_nav'){ page.should have_text 'Store Tools' }
        end
      end # store_user

      describe 'Visiting root as no one' do
        before(:each) do
          visit '/'
        end

        specify 'root should be menu(current_menu)' do
          page.current_path.should == menu_path(store.current_menu)
        end
      end # no user
    end # after store creation
  end
end