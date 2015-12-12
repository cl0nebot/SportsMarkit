class LeaguesController < ApplicationController
  before_action :correct_user!, only: [:edit]
  before_action :find_league, only: [:show, :edit, :destroy]
  
  def index
    @leagues = League.all
    @object = League.new
    @address = @object.build_address 
  end
  
  def new
    @object = League.new
    @address = @object.build_address 
  end
  
  def create
    @league = League.new(league_params)
    if @league.save
      if current_user
        unless current_user.admin?
          Role.create(user_id: current_user.id, roleable_type: "League", roleable_id: @league.id, role: "League Manager", status: "Active")
        end
			end
      redirect_to @league
    else
      render 'new'
    end
  end
  
  def show
    @object = @league
    shared_variables
    @teams = @league.teams
    @manager_and_trainers = @league.manager_and_trainers
    @userless_managers_and_trainers = @league.userless_managers_and_trainers
    @admins = @league.admins
    @userless_admins = @league.userless_admins
    @facilities = @league.used_facilities
  end
  
  
  def edit
    @object = @league
    @picture =  @object.photos.build
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    profile_picture_insert
  end
  
  def update
    @object = League.find_by_slug!(request.referrer.split("leagues/").last.split("/").first)
    @profile_picture =  ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s).last
    @profile_pictures = ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s)
    @videos = @object.medias.where(category: "Video")
    @articles = @object.medias.where(category: "Article")
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    if @object.update_attributes(league_params)
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
    @league.destroy
    redirect_to :back
  end
  
  def managers
    @league_managers = Role.where(roleable_type: "League", roleable_id: @league.id, role: "League Manager", status: "Active")
  end
  
  protected
  
  def find_league
    @league = League.friendly.find(params[:id])
  end
  
  def league_params
    params.require(:league).permit({:sport_ids => []}, :name, :description, :sport, :website, :emails, :slug, :classification, :category, :facebook, :twitter, :linkedin, :pinterest, :instagram, :youtube, :phone_number, {address_attributes: [:id, :addressable_id, :addressable_type, :street_1, :street_2, :city, :state, :country, :postcode, :suite, :nickname, :default, :county, :latitude, :longitude, :gmaps]})  
  end
  
  
end