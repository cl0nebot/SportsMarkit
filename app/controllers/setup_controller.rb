class SetupController < ApplicationController
  before_action :find_user, except: [:test_setup, :delete_role, :add_role, :create_object]
  
  def setup
    @athlete_teams = Team.where.not(id: @user.roles.where(status: "Active", role: "Athlete", roleable_type: "Team").pluck(:roleable_id))
    @coach_teams = Team.where.not(id: @user.roles.where(status: "Active", role: "Coach", roleable_type: "Team").pluck(:roleable_id))
    @athletes = User.athletes
  end
  
  def create_object
    @user = User.find(params[:user_id])
    object_type = params[:object_type]
    @object = object_type.constantize.new(eval("#{object_type.downcase}_params"))
    if @object.save
      Role.create(roleable_id: @object.id, roleable_type: object_type, user_id: @user.id , status: "Pending", role: params[:role])
      respond_to do |format|
        format.js
        format.html
      end
    else

    end
    
   
  end
  
  def overview
    render layout: "minimal"
  end
  
  def add_role
    @user = User.friendly.find(params[:user_id])
    role = Role.create(user_id: params[:user_id], role: params[:role], roleable_id: params[:roleable_id], roleable_type: params[:roleable_type], status: params[:status])
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def delete_role
    @user = User.friendly.find(params[:user_id])
    @role = Role.find(params[:role_id])
    @role.destroy
    respond_to do |format|
      format.js
      format.html
    end
  end

  protected
  
  def find_user
    @user = User.friendly.find(params[:id])
  end
  
  def team_params
    params.require(:team).permit(:name, :sport, :league_id, :classification, :description, :abbreviation, :phone_number, :email, :website, :slug, :facebook, :twitter, :linkedin, :pinterest, :instagram, :foursquare, :youtube, {address_attributes: [:id, :addressable_id, :addressable_type, :street_1, :street_2, :city, :state, :country, :postcode, :suite, :nickname, :default, :county, :latitude, :longitude, :gmaps]})  
  end
  
  def school_params
    params.require(:school).permit(:name, :classification, :category, :abbreviation, :description, :phone_number, :email, :website, :slug, :stripe_token, :facebook, :twitter, :linkedin, :pinterest, :instagram, :foursquare, :youtube, :founded, :enrollment, :faculty, {address_attributes: [:id, :addressable_id, :addressable_type, :street_1, :street_2, :city, :state, :country, :postcode, :suite, :nickname, :default, :county, :latitude, :longitude, :gmaps]})  
  end
  
  def club_params
    params.require(:club).permit(:name, :classification, :category, :abbreviation, :phone_number, :email, :website, :slug, :stripe_token, :facebook, :twitter, :linkedin, :pinterest, :instagram, :foursquare, :youtube, :founded, :enrollment, :faculty, {address_attributes: [:id, :addressable_id, :addressable_type, :street_1, :street_2, :city, :state, :country, :postcode, :suite, :nickname, :default, :county, :latitude, :longitude, :gmaps]})  
  end
  
end
