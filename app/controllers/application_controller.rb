class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # users

  def new_user
    @user ||= User.new
  end

  def current_user
    @current_user ||= User.find_by_authentication_token(cookies[:authentication_token]) if cookies[:authentication_token]
  end

  helper_method :new_user, :current_user
  
  #authentication

  def authenticate_user!
    redirect_to signup_path, alert: "Not authorized" if current_user.nil?
  end
  
end
