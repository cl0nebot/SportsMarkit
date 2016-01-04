class FacilitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user!, only: [:edit]
  before_action :find_facility, only: [:show, :edit, :destroy]
  
  
  def index
    if stale?(:etag => ["facilites-index", "v0"], :last_modified => Facility.maximum(:updated_at))
      if params[:school_id]
        @school = School.friendly.find(params[:school_id])
        @facilities = @school.facilities.all
      else
        @facilities = Facility.all
      end
    end
  end
  
  def new
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @owner = $1.try(:capitalize).try(:constantize).try(:find, params[param])
    @owner_type = @owner.try(:class).try(:to_s)
    @owner_id = @owner.try(:id)
    @object = Facility.new
    @address = @object.build_address
  end
  
  def create
    @object = Facility.new(facility_params)
    if @object.save
      redirect_to @object.facility_owner if @object.facility_owner.present?
      redirect_to @object unless @object.facility_owner.present? 
    else
      render 'new'
    end
  end
  
  def create_from_modal
    if (params[:facility][:address_attributes][:street_1].present? && params[:facility][:address_attributes][:city].present? || params[:facility][:address_attributes][:state].present?)
      @object = Facility.new(facility_params)
      if @object.save
        @facilities = @object.facility_owner.facilities
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
      else
        flash[:error] = "Facility needs a name and a valid address."
        @owner = params[:facility][:facility_owner_type].constantize.find(params[:facility][:facility_owner_id])
        @facilities = @owner.facilities
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
        end
      end
    else
      flash[:error] = "Address is invalid."
      @owner = params[:facility][:facility_owner_type].constantize.find(params[:facility][:facility_owner_id])
      @facilities = @owner.facilities
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    end
  end
  

  
  
  
  def show
    @class = @facility.class
    @object = @facility
    @teams = @facility.all_teams
    @users_of_facility = @facility.people 
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
  
  def remove_facility
    @facility = Facility.find(params[:id])
    @facility.destroy
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
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
    params.require(:facility).permit(:school_id, :team_id, :name, :field_type, :is_private, :publicly_visible, :facility_type, :phone_number, :email, :website, {address_attributes: [:id, :addressable_id, :addressable_type, :street_1, :street_2, :city, :state, :country, :postcode, :suite, :nickname, :default, :county, :latitude, :longitude, :gmaps]}, :slug, :facility_owner_id, :facility_owner_type, :facebook, :twitter, :linkedin, :pinterest, :instagram, :foursquare, :youtube)  
  end
end