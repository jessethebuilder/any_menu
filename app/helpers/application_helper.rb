module ApplicationHelper
  include HtmlTools

  ::USER_TYPES = ['customer', 'owner', 'store_user']
  ::DINING_LOCATIONS = %w|deliver dine_in take_out|
  ::MENU_PACKAGES = ['single_menu']

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

  def current_order
    if user_signed_in?
      #current_user.orders.where(:complete => false).last || current_user.orders.new()
    else
      current_order_for_unknown_user
    end
  end

  def current_order?
    if user_signed_in?

    else
      session[:current_order_id] && Order.exists?(session[:current_order_id])
    end
  end

  private

  def current_order_for_unknown_user
    if current_order?
      Order.find(session[:current_order_id])
    else
      order = Order.create
      session[:current_order_id] = order.id
      order
    end
  end

end


