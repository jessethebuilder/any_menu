module ApplicationHelper
  include HtmlTools

  def store
    Store.first
  end

  def store_name
    Store.first ? Store.first.name : 'Any Menu Template'
  end

  def first_use?
    Store.all.empty?
  end

  def owner?
    r = false
    if current_user
      r = true if current_user.user_type == 'owner'
    end
    r
  end

  def super_user?
    r = false
    if current_user
      r = true if current_user.user_type == 'owner' || current_user.user_type == 'store_user'
    end
    r
  end

  ::USER_TYPES = ['customer', 'owner', 'store_user']
  ::MENU_PACKAGES = ['single_menu']
end


