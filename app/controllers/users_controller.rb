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
      redirect_to user_overview_path(@user)
    else
      render 'new'
    end
  end
  
  def show
    @user = User.friendly.find(params[:id])
    @class = @user.class
    @object = @user
    @team_ids = @user.relationships.where(accepted: true).pluck(:team_id)
    @teammate_ids = Relationship.where(team_id: @team_ids, accepted: true).pluck(:user_id)
    @teammates = User.where(id: @teammate_ids).uniq - [@user]
    @teams = Team.where(id: @team_ids)
    @fans = @user.fans
    @follows = @user.follows
    @videos = @user.medias.where(category: "Video")
    @articles = @user.medias.where(category: "Article")
  end
  
  def edit
    @profile = @user.build_profile if @user.profile.nil?
    @profile = @user.profile
    @user_profile_picture = @user.user_profile_pictures.build if @user.user_profile_pictures.empty?
    @user_profile_picture = @user.user_profile_pictures.last
    @object = @user
  end
  
  def update
    unless params[:user][:password].present?
      @profile = @user.profile
      if @user.update_attributes(user_params)
        @user.relationships.update_all(mobile_phone_number: @user.mobile_phone_number)
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

  def add_school_team_at_setup
    @user = User.friendly.find(params[:user_id])
    @relationship = Relationship.create(team_id: params[:relationship][:team_id], user_id: params[:relationship][:user_id], participant: params[:relationship][:participant])
    @school_teams = Team.with_schools - @user.teams
    @users_schools_teams_ids = Relationship.where(user_id: @user.id, participant: true).pluck(:team_id)
    @users_schools_teams = Team.with_schools.where(id: @users_schools_teams_ids)
    respond_to do |format|
      format.js 
      format.html { redirect_to :back }
    end
  end

  def remove_school_team
    r = Relationship.where(team_id: params[:team_id], user_id: params[:user_id], participant: true).first
    r.destroy
    @team = r.team
  end

  def remove_non_school_team
    r = Relationship.where(team_id: params[:team_id], user_id: params[:user_id], participant: true).first
    r.destroy
    @team = r.team
  end

  def remove_coach_team
    r = Relationship.where(team_id: params[:team_id], user_id: params[:user_id]).first
    r.destroy
    @team = r.team
  end

  def add_non_school_team_at_setup
    @user = User.friendly.find(params[:user_id])
    @relationship = Relationship.create(team_id: params[:relationship][:team_id], user_id: params[:relationship][:user_id], participant: params[:relationship][:participant])
    @users_non_schools_teams_ids = Relationship.where(user_id: @user.id, participant: true).pluck(:team_id)
    @users_non_schools_teams = Team.without_schools.where(id: @users_non_schools_teams_ids)
    @non_school_teams = Team.without_schools - @user.teams
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  
  def add_coach_team_at_setup
    @user = User.friendly.find(params[:user_id])
    @relationship = Relationship.create(team_id: params[:relationship][:team_id], user_id: params[:relationship][:user_id], head: params[:relationship][:head])
    @coached_teams = @user.coached_teams
    @coachable_teams = Team.all - @coached_teams
    respond_to do |format|
      format.js 
      format.html { redirect_to :back }
    end
  end
  
  def add_athletic_director_at_setup
    @user = User.friendly.find(params[:user_id])
    @athletic_director = AthleticDirector.create(school_id: params[:athletic_director][:school_id], user_id: params[:athletic_director][:user_id])
    @school = @athletic_director.school
    @schools = School.all - [@school]
    respond_to do |format|
      format.js 
      format.html { redirect_to :back }
    end
  end

  def remove_child
    rel = ParentChild.where(child_id: params[:child_id], parent_id: params[:user_id]).first
    rel.destroy
    @child = rel.child
  end
  
  def add_child_at_setup
    @user = User.friendly.find(params[:user_id])
    @parent_child = ParentChild.create(child_id: params[:parent_child][:child_id], parent_id: params[:parent_child][:parent_id])
    @children = @user.children
    @available_children = User.all - [@user] - @user.children
    respond_to do |format|
      format.js 
      format.html { redirect_to :back }
    end
  end
  
  def email
    @user = User.friendly.find(params[:user_id])
    if @user.email.present?
      #redirect_to edit_user_path(@user)
    else
      
    end
  end
  
  def update_email
    
  end
  
  # def add_non_school_team_at_setup
  #   @user = User.friendly.find(params[:user_id])
  #   respond_to do |format|
  #     format.js
  #     format.html { redirect_to :back }
  #   end
  # end

  protected
  
  def user_params
   params.require(:user).permit({:team_ids => []}, :prefix, :name, :first_name, :middle_name, :last_name, :suffix, :email, :username,:mobile_phone_number,  :password, :password_confirmation, :current_password, {profile_attributes: [:id, :user_id, :instagram, :twitter, :facebook, :linkedin, :hudl, :youtube, :pinterest, :foursquare, :date_of_birth, :favorite_pro_team, :favorite_college_team, :favorite_pro_athlete, :mobile_phone_number, :undergraduate_school, :graduate_school, :doctorate_school, :undergraduate_major, :graduate_major, :doctorate_major, :undergraduate_year, :graduate_year, :doctorate_year, :undergraduate_degree, :graduate_degree, :doctorate_degree, :height_ft, :height_in, :weight, :sex, :team, :league, :primary_position, :secondary_position, :level, :guardian, :guardian_phone_number, :company, :title, :website, :agency, :industries, :interests, :skills, :city, :offseason_city, :state, :zipcode, {sports: []}, {skills: []}, {specialties: []}, {injuries: []}, {current_ailments: []}, {focus: []}, :category, :mobile_phone_number ]},  {user_profile_pictures_attributes: [:id, :user_id, :photo]}, {user_addresses_attributes: [:id, :user_id, :street_1, :street_2, :city, :state, :country, :zip, :apt_no]} )
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

