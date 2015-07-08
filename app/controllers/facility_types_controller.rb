class FacilityTypesController < ApplicationController
  def index
    @facility_types = FacilityType.all
    @facility_type = FacilityType.new
  end
  
  def create
    @facility_type = FacilityType.new(facility_type_params)
    if @facility_type.save
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      flash.now[:error] = @facility_type.errors.full_messages
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    end
  end
  
  def update
    @facility_type = FacilityType.find(params[:id])
    @index = @facility_type.index_position
    @before_item = @index - 1
    @result = @facility_type.update_attributes(facility_type_params)
    if @result
      flash[:success] = "Event Type has been updated."
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    else
      flash.now[:error] = @facility_type.errors.full_messages
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    end
  end
  
  def destroy
    @facility_type = FacilityType.find(params[:id])
    @index = @facility_type.index_position
    @facility_type.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  
  protected
  
  def facility_type_params
    params.require(:facility_type).permit(:facility_type)
  end
end
  