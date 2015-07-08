class AmenitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  
  def index
    @amenities = Amenity.all
    @amenity = Amenity.new
  end
  
  def create
    @amenity = Amenity.new(amenity_params)
    if @amenity.save
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      flash.now[:error] =  @amenity.errors.full_messages
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    end
  end
  
  def update
    @amenity = Amenity.find(params[:id])
    @index = @amenity.index_position
    @before_item = @index - 1
    @result = @amenity.update_attributes(amenity_params)
    if @result
      flash[:success] = "Amenity has been updated."
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    else
      flash.now[:error] = @amenity.errors.full_messages
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    end
  end
  
  def destroy
    @amenity = Amenity.find(params[:id])
    @index = @amenity.index_position
    @amenity.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  
  protected
  
  def amenity_params
    params.require(:amenity).permit(:amenity)
  end
end
  
