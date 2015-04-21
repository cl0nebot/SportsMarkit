class SessionsController < ApplicationController


  respond_to :html, :json

  def new
    if current_user
      redirect_to root_path
    end
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      cookies.permanent[:authentication_token] = user.authentication_token
      p "----------------"
      user.errors.full_messages
      redirect_to users_path
    else
      flash[:error] = "Email or password is incorrect."
      render text: user.errors.full_messages
    end
    # respond_to do |format|
    #   format.json { render(json: flash.to_h); flash.clear }
    #   format.html { redirect_to request.referrer }
    # end
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
