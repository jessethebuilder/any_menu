module RequestHelper
  def make_store_and_login_as_owner
    store = create :store
    owner = create :owner
    login(owner)
    store
  end

  def login_owner
    create :store
    owner = create :owner
    login(owner)
    owner
  end

  def login(user)
    visit '/users/sign_in'
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => 'testtest'
    click_button 'Sign in'
  end

  def fill_in_date_time(field_name, datetime)
    select datetime.year, :from => "#{field_name}_1i"
    select datetime.strftime('%B'), :from => "#{field_name}_2i"
    select datetime.day, :from => "#{field_name}_3i"
    select datetime.strftime('%I %p'), :from => "#{field_name}_4i"
    select datetime.strftime('%M'), :from => "#{field_name}_5i"
  end
end