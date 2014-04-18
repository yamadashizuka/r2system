class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :authenticate_user!
    
  before_filter :configure_permitted_parameters, if: :devise_controller?

  after_filter :crumble_bread, only: [:index, :show]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:userid, :name, :email, :password, :password_confirmation, :remember_me, :category, :company_id) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:userid, :name, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:userid, :name, :email, :password, :password_confirmation, :current_password, :category, :company_id) }
  end
  
  def crumble_bread
    session[:breadcrumbs] ||= []
    session[:breadcrumbs].pop unless session[:breadcrumbs].size < 5
    session[:breadcrumbs].unshift(request.original_fullpath)
  end
end
