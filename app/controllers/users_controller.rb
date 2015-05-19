class UsersController < ApplicationController
  #before_action :authenticate_user!, only: %w[index show edit update destroy plans subscriptions]
  before_action :find_user, only: %w[show edit update destroy store]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      Profile.create(user_id: @user.id, focus: [], specialties: [], skills: [], injuries: [], current_ailments: [])
      cookies.permanent[:authentication_token] = @user.authentication_token
      flash[:success] = "Signed up."
      #Emails.user_signup(@user).deliver
      redirect_to user_user_setup_path(@user)
    else
      render 'new'
    end
  end
  
  def show
    @user = User.friendly.find(params[:id])
    @class = @user.class
    @object = @user
    @team_ids = @user.relationships.pluck(:team_id)
    @teammate_ids = Relationship.where(team_id: @team_ids).pluck(:user_id)
    @teammates = User.where(id: @teammate_ids).uniq - [@user]
    @teams = Team.where(id: @team_ids)
  end
  
  def edit
    @profile = @user.build_profile if @user.profile.nil?
    @profile = @user.profile
    @user_profile_picture = @user.user_profile_pictures.build if @user.user_profile_pictures.empty?
    @user_profile_picture = @user.user_profile_pictures.last
  end
  
  def update
    unless params[:user][:password].present?
      @profile = @user.profile
      if @user.update_attributes(user_params)
        flash[:success] = "Updated successfully."
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
          format.json { respond_with_bip(@user) } 
        end
      else
        respond_to do |format|
          format.html{render :edit}
          format.js
          format.json { respond_with_bip(@user) }
        end
      end
    else
      if @user == @user.authenticate(params[:user][:current_password])
        @profile = @user.profile
        @user.update_attributes(user_params)
        flash[:success] = "Password Changed."
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
          format.json { respond_with_bip(@user) }
        end
      else
        flash[:error] = "Current Password is not a match."
        respond_to do |format|
          format.html{render :edit}
          format.js
          format.json { respond_with_bip(@user) }
        end
      end
    end
  end
  
  def privileges
    @user = User.friendly.find(params[:user_id])
    @privileges = GrantedPrivilege.where(user_id: @user.id)
  end
  
  def store
    #@inventory_products = InventoryProduct.where( user_id: @user.id )
  end
  
  def destroy
    @index = @user.index_position
    @user.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
    
  end
  
  def welcome
    @user = User.find_by_mobile_phone_number(params[:m])
    
  end
  
  def purchases
    @user = User.friendly.find(params[:user_id])
    @purchases = @user.purchase
  end
  
  def setup
    @user = User.friendly.find(params[:user_id])
  end
  
  def overview
    @user = User.friendly.find(params[:user_id])
  end
  
  protected
  
  def user_params
   params.require(:user).permit(:prefix, :name, :first_name, :middle_name, :last_name, :suffix, :email, :username,  :password, :password_confirmation, :current_password, {profile_attributes: [:id, :user_id, :instagram, :twitter, :facebook, :linkedin, :hudl, :youtube, :pinterest, :foursquare, :date_of_birth, :favorite_pro_team, :favorite_college_team, :favorite_pro_athlete, :mobile_phone_number, :undergraduate_school, :graduate_school, :doctorate_school, :undergraduate_major, :graduate_major, :doctorate_major, :undergraduate_year, :graduate_year, :doctorate_year, :undergraduate_degree, :graduate_degree, :doctorate_degree, :height_ft, :height_in, :weight, :sex, :team, :league, :primary_position, :secondary_position, :level, :guardian, :guardian_phone_number, :company, :title, :website, :agency, :industries, :interests, :skills, :city, :offseason_city, :state, :zipcode, {sports: []}, {skills: []}, {specialties: []}, {injuries: []}, {current_ailments: []}, {focus: []}, :category, :mobile_phone_number ]},  {user_profile_pictures_attributes: [:id, :user_id, :photo]}, {user_addresses_attributes: [:id, :user_id, :street_1, :street_2, :city, :state, :country, :zip, :apt_no]} )
  end
  
  def redirect_to_profile_if_current_user
    if current_user
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end
  
  def find_user
    @user = User.friendly.find(params[:id])
  end
  
end

