class UserProfilePicturesController < ApplicationController
  before_action :find_user
  
  def create
    @user_profile_picture = @user.user_profile_pictures.build(user_profile_params)
    @user_profile_pictures = @user.user_profile_pictures.to_a
    if @user_profile_picture.save
      respond_to do |format|
        format.js
        format.html do
          flash[:success] = "Profile picture added successfully."
          redirect_to edit_user_path(@user)
        end
      end
    else
      format.js
      format.html do
        flash[:error] = "Profile picture not uploaded. Try again."
        redirect_to edit_user_path(@user)
      end
    end
  end
  
  def update
    @user_profile_picture = @user.user_profile_pictures.last #instead of finding by :id, always finds last; updates
    @user_profile_pictures = @user.user_profile_pictures.to_a
    @user_profile_picture.user_id = User.friendly.find(params[:user_id]).id
    @user_profile_picture.update_attributes(user_id: @user.id, photo: params[:user_profile_picture][:photo])
  end
  
  def destroy
    @user_profile_picture = @user.user_profile_pictures.find(params[:id])
    @user_profile_picture.destroy
    @user_profile_pictures = @user.user_profile_pictures.where.not(id: nil)
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  protected
  
  def user_profile_params
    params.require(:user_profile_picture).permit(:user_id, :photo)
  end
  
  def find_user
    @user = User.friendly.find(params[:user_id])
  end
end
