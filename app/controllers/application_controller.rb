class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:first_name, :last_name, :user_type, :email, :password)}
  end

  def authenticate_super_user!
    redirect_to new_user_session_path, :alert => 'You must be signed in as an Store User to visit that page.' unless user_signed_in?
    redirect_to root_path, :alert => 'You must be signed in as an Store User to visit that page.' unless current_user.super_user?
  end
end
