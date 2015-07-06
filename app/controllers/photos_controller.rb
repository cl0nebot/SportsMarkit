class PhotosController < ApplicationController
  before_filter :set_photo_owner, only: :create

  def create
    @photo_owner.photos.create(photo_params)
    redirect_to :back
  end

  def update
    Photo.find(params[:id]).update_attributes(photo_params)
    redirect_to :back
  end

  private
    def set_photo_owner
      param = params.keys.find{|key| key =~ /(\w+)_id/}
      @photo_owner = $1.capitalize.constantize.find(params[param])
    end

    def photo_params
      params.require(:photo).permit(:image, :main, :image_crop_x, :image_crop_y, :image_crop_w, :image_crop_h, :offset_x, :offset_y, :zoom, :photo_owner_id, :photo_owner_type, :image)
    end

end