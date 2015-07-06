class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :xeditable?


  ALPHABET_ARRAY = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
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

  def xeditable?
    true # Or something like current_user.xeditable?
  end
  
  def generate_temporary_password(first_name)
    first_part = first_name.delete(' ').downcase.reverse
    name_array = first_name.split("")
    array = []
    second_part = name_array.each do |letter|
      array << ALPHABET_ARRAY.index(letter)
    end
    first_part.last(3) + array.join.last(5) + first_part.first(3)
  end
  
  def authenticate_user!
    redirect_to signup_path, alert: "Not authorized" if current_user.nil?
  end
  
  def authenticate_user_account
    authenticate_user!
    unless current_user.admin? or current_user == User.friendly.find(params[:id])
      flash[:message] = "This is your account."
      redirect_to edit_user_path(current_user)
      #render :file => "public/401.html", :status => :unauthorized
    end
  end
  
  
  
end
