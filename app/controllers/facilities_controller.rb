class FacilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
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
    if params[:facility][:facility_owner_type].present? 
      @object = params[:facility][:facility_owner_type].constantize.find(params[:facility][:facility_owner_id])
      @facility = @object.facilities.build(facility_params)
      if @facility.save
        FacilityLink.find_or_create_by(facility_id: @facility.id, facilitatable_type: params[:facility][:facility_owner_type], facilitatable_id: params[:facility][:facility_owner_id])
        redirect_to "#{request.referrer}#tab_facilities"
      else
        redirect_to :back
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
    @picture =  @object.photos.build
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    @teams = @facility.all_teams
    @users_of_facility = @facility.people_that_use_facility
    @videos = @facility.medias.where(category: "Video")
    @articles = @facility.medias.where(category: "Article")
     @fans = @facility.fans
  end
  
  def edit
    @object = @facility
    @picture =  @object.photos.build
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
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
  
  def selection_option
    
  end
  
  protected
  
  def find_facility
    @facility = Facility.friendly.find(params[:id])
  end
  
  def facility_params
    params.require(:facility).permit(:school_id, :team_id, :name, :field_type, :private, :publicly_visible, :address_1, :address_2, :city, :state, :zip, :zip_ext, :latitude, :longitude, :gmaps, :phone_number, :email, :website, :slug, :facility_owner_id, :facility_owner_type)
  end
end