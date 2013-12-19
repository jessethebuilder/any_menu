module RequestHelper
  def make_store_and_login_as_owner
    store = create :store_with_owner
    owner = store.users.last
    login(owner)
    store
  end

  def login(user)
    visit '/users/sign_in'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => 'testtest'
    click_button 'Sign in'
  end
end