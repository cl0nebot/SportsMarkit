class ProfilePicturesController < ApplicationController
  before_action :find_profile_picture_owner
  
  def create
    @profile_picture = @owner.profile_pictures.build(profile_picture_params)
    @profile_pictures = @owner.profile_pictures.to_a
    if @profile_picture.save
      respond_to do |format|
        format.js
        format.html do
          flash[:success] = "Profile picture added successfully."
          redirect_to eval("edit_#{@owner.class.to_s.downcase}_path(@owner)")
        end
      end
    else
      format.js
      format.html do
        flash[:error] = "Profile picture not uploaded. Try again."
        redirect_to eval("edit_#{@owner.class.to_s.downcase}_path(@owner)")
      end
    end
  end
  
  def update
    @profile_picture = @owner.profile_pictures.last #instead of finding by :id, always finds last; updates
    @profile_pictures = @owner.profile_pictures.to_a
    @profile_picture.profile_picture_owner_type = @owner.class.to_s
    @profile_picture.profile_picture_owner_id = @owner.id
    @profile_picture.update_attributes(profile_picture_owner_id: @owner.id, profile_picture_owner_type: @owner.class.to_s, photo: params[:profile_picture][:photo])
    redirect_to :back
  end
  
  def destroy
    @profile_picture = @owner.profile_pictures.find(params[:id])
    @profile_picture.destroy
    @profile_pictures = @owner.profile_pictures.where.not(id: nil)
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  private
  
    def profile_picture_params
      params[:profile_picture].permit(:photo, :profile_picture_owner_type, :profile_picture_owner_id)
    end
  
    def find_profile_picture_owner
      param = params.keys.find{|key| key =~ /(\w+)_id/}
      @owner = $1.capitalize.constantize.find(params[param])
    end
  
end
