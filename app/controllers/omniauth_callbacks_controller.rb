class OmniauthCallbacksController < ApplicationController
  
  def facebook
    user = User.from_omniauth(env["omniauth.auth"])
    if user.persisted?
      cookies.permanent[:authentication_token] = user.authentication_token
      flash[:success] = "Signed in."
    else
      flash[:error] = "Oops!"
    end
    redirect_to request.referrer
  end
  
end
