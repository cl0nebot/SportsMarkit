class UserProfilePicturesController < ApplicationController
  before_action :find_user
  before_action :find_picture, except: %w[index new create]
  
  
  def index
    @pictures = UserProfilePicture.where(user_id: @user.id)
  end
  
  def new
    @picture = @user.user_profile_pictures.build
  end
  
  def create
    @picture = @user.user_profile_pictures.build(user_profile_picture_params)
    if @picture.save
      redirect_to :back
    else
      render 'new'
    end
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    if @picture.update_attributes(user_profile_picture_params)
      redirect_to user_user_profile_pictures_path(@user)
    else
      render 'edit'
    end
  end
  
  def destroy
    @picture.destroy
    redirect_to :back
  end
  
  protected
  
  def find_user
    @user = User.friendly.find(params[:user_id])
  end
  
  def find_picture
    @picture = @user.user_profile_pictures.find(params[:id])  
  end
  
  def user_profile_picture_params
    params.require(:user_profile_picture).permit(:name, :description, :photo, :user_id)
  end
end