class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(_resource)
    radars_path
  end

  def authenticate_admin
    return if current_user && current_user.admin?
    redirect_to root_url, notice: "Access denied, admin only"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    # devise_parameter_sanitizer.for(:sign_up) do |user|
    #   user.permit(:username, :email, :password, :password_confirmation, :remember_me)
    # end

    devise_parameter_sanitizer.for(:sign_in) << :username
    # devise_parameter_sanitizer.for(:sign_in) do |user|
    #   user.permit(:login, :username, :email, :password, :remember_me)
    # end

    devise_parameter_sanitizer.for(:account_update) << :username
    # devise_parameter_sanitizer.for(:account_update) do |user|
    #   user.permit(:username, :email, :password, :password_confirmation, :current_password)
    # end
  end
end
