class FacilitiesController < ApplicationController
  before_action :find_facility, only: [:show, :edit, :update, :destroy]
  
  
  def index
    if params[:school_id]
      @school = School.friendly.find(params[:school_id])
      @facilities = @school.facilities.all
    else
      @facilities = Facility.all
    end
  end
  
  def new
    if params[:school_id]
      @school = School.friendly.find(params[:school_id])
      @facility = @school.facilities.build
    else
      @facility = Facility.new
    end
  end
  
  def create
    if request.referrer.split("/")[3] == "schools"
      @school = School.find_by_slug(request.referrer.split("/")[4])
      @facility = @school.facilities.build(facility_params)
      if @facility.save
        redirect_to "/facilities/#{@facility.slug}"
      else
        render 'new'
      end
    else
      @facility = Facility.new(facility_params)
      if @facility.save
        redirect_to :back
      else
        render 'new'
      end
    end
  end
  
  def show
    @json = @facility.to_gmaps4rails
    @class = @facility.class
    @object = @facility
    @teams = @facility.all_teams
    @users_of_facility = @facility.people_that_use_facility
  end
  
  def edit
    @object = @facility
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
    params.require(:facility).permit(:school_id, :team_id, :name, :field_type, :private, :publicly_visible, :address_1, :address_2, :city, :state, :zip, :zip_ext, :latitude, :longitude, :gmaps, :phone_number, :email, :website, :slug )
  end
end