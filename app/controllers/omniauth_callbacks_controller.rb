class OmniauthCallbacksController < ApplicationController
  def facebook
    user = User.from_omniauth(env["omniauth.auth"])
    if user.persisted?
      cookies.permanent[:authentication_token] = user.authentication_token
      Profile.create(user_id: user.id, focus: [], specialties: [], skills: [], injuries: [], current_ailments: [])
      flash[:success] = "Signed in."
    else
      flash[:error] = "Oops!"
    end
    redirect_to request.referrer
  end
end
