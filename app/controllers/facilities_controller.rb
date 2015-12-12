class FacilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user!, only: [:edit]
  before_action :find_facility, only: [:show, :edit, :destroy]
  
  
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
      @object = Facility.new
      @address = @object.build_address
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
    @class = @facility.class
    @object = @facility
    @teams = @facility.all_teams
    @users_of_facility = @facility.people_that_use_facility
    shared_variables
  end
  
  def edit
    @object = @facility
    @picture =  @object.photos.build
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    profile_picture_insert
  end
  
  def update
    @object = Facility.find_by_slug!(request.referrer.split("facilities/").last.split("/").first)
    @profile_picture =  ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s).last
    @profile_pictures = ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s)
    @videos = @object.medias.where(category: "Video")
    @articles = @object.medias.where(category: "Article")
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    if @object.update_attributes(facility_params)
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
        format.json { respond_with_bip(@object) } 
      end
    else
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
        format.json { respond_with_bip(@object) } 
      end
      
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
    params.require(:facility).permit(:school_id, :team_id, :name, :field_type, :private, :publicly_visible, :facility_type, :phone_number, :email, :website, {address_attributes: [:id, :addressable_id, :addressable_type, :street_1, :street_2, :city, :state, :country, :postcode, :suite, :nickname, :default, :county, :latitude, :longitude, :gmaps]}, :slug, :facility_owner_id, :facility_owner_type, :facebook, :twitter, :linkedin, :pinterest, :instagram, :foursquare, :youtube)  
  end
end