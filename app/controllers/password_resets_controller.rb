class PasswordResetsController < ApplicationController
  
  def new
    
  end
  
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    cookies.delete(:authentication_token)
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  def edit
    @user = User.find_by_reset_password_token!(params[:id])
  end
  
  def update
    @user = User.find_by_reset_password_token!(params[:id])
    if @user.reset_password_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password has expired."
    elsif @user.update_attributes(user_params) #TODO strong params
      flash[:success] = "Password has been reset."
      redirect_to login_path
    else
      render :edit
    end
  end
  
  protected
  
  def user_params
    params.require(:user).permit(:password, :password_digest)
  end
end


