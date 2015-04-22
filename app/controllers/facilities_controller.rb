class FacilitiesController < ApplicationController
  before_action :find_facility, only: [:show, :edit, :update, :destroy]
  
  
  def index
    @facilities = Facility.all
  end
  
  def new
    @facility = Facility.new
  end
  
  def create
    @facility = Facility.new(facility_params)
    if @facility.save
      redirect_to facilities_path
    else
      render 'new'
    end
  end
  
  def show
    @json = @facility.to_gmaps4rails
    @class = @facility.class
    @object = @facility
  end
  
  def edit
    
  end
  
  def update
    if @facility.update_attributes(facility_params)
      redirect_to :back
    else
      render :edit
    end
  end
  
  def destroy
    @facility.destroy
    redirect_to :destroy
  end
  
  protected
  
  def find_facility
    @facility = Facility.friendly.find(params[:id])
  end
  
  def facility_params
    params.require(:facility).permit(:name, :field_type, :private, :publicly_visible, :address_1, :address_2, :city, :state, :zip, :zip_ext, :latitude, :longitude, :gmaps, :phone_number, :email, :website, :slug )
  end
end

