class SessionsController < ApplicationController


  respond_to :html, :json

  def new
    if current_user
      redirect_to root_path
    end
  end

  def create
    user = User.where(email: params[:identifier]).first if params[:identifier].include?("@")
    user = User.where(mobile_phone_number: params[:identifier]).first unless params[:identifier].include?("@")
    if user && user.authenticate(params[:password])
      cookies.permanent[:authentication_token] = user.authentication_token
      user.errors.full_messages
      redirect_to users_path
    else
      flash[:error] = "Email or password is incorrect."
      p user.full_errors
      redirect_to :back
    end
  end

  def show;end

  def destroy
    cookies.delete(:authentication_token)
    redirect_to root_url
  end

  def check_email
    user = User.where( email: params[:email] ).first
    result = {}
    result[:available] = user.nil?
    if user
      result[:name] = user.full_name
    end
    respond_to do |format|
      format.json { render json: result }
    end
  end
end
