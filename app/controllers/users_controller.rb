class UsersController < ApplicationController
  before_action :authenticate_user!, only: %w[index edit update destroy plans subscriptions]
  before_action :correct_user!, only: %w[edit]
  before_action :find_user, only: %w[show edit destroy store]

  def index
    if stale?(:etag => ["users-index", "v0"], :last_modified => [User.maximum(:updated_at), UserProfilePicture.maximum(:updated_at)].max)
      @users = User.includes(:profile, :user_profile_pictures).all
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      Profile.create(user_id: @user.id, focus: [], specialties: [], skills: [], injuries: [], current_ailments: [])
      cookies.permanent[:authentication_token] = @user.authentication_token
      @user.increment!(:signin_count)
      flash[:success] = "Signed up."
      #Emails.user_signup(@user).deliver
      if params[:registration]
        redirect_to :back
      else
        redirect_to user_overview_path(@user)
      end
    else
      render 'new'
    end
  end

  def show
    @user = User.friendly.find(params[:id])
    @object = @user
    @class = @object.class
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    @teammates = @object.teammates
    @teams = Team.where(id: @object.team_ids)
    @fans = @object.fans
    @follows = @object.follows
    @videos = @object.medias.where(category: "Video")
    @articles = @object.medias.where(category: "Article")
  end

  def edit
    @profile = @user.build_profile if @user.profile.nil?
    @profile = @user.profile
    @user_profile_picture =  UserProfilePicture.where(user_id: @user.id).empty? ? @user.user_profile_pictures.build : UserProfilePicture.where(user_id: @user.id).last
    @user_profile_pictures = UserProfilePicture.where(user_id: @user.id)
    @object = @user
    @picture =  @object.photos.build
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    @videos = @object.medias.where(category: "Video")
    @articles = @object.medias.where(category: "Article")
  end

  def update
    @user = User.find_by_slug!(params[:id])
    @user_profile_picture =  UserProfilePicture.where(user_id: @user.id).last
    @user_profile_pictures = UserProfilePicture.where(user_id: @user.id)
    @object = @user
    @videos = @object.medias.where(category: "Video")
    @articles = @object.medias.where(category: "Article")
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    @email_taken = @object.minus_self.exists?(:email => params[:user][:email])
    @phone_taken = params[:user][:mobile_phone_number].present? ? @object.minus_self.exists?(:mobile_phone_number => params[:user][:mobile_phone_number]) : false
    p @email_taken
    p @phone_taken
    if @email_taken
      # @email_message = "The email address, #{params[:user][:email]}, is already taken."
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
        format.json { respond_with_bip(@user) }
      end
    elsif @phone_taken
      # @email_message = "The email address, #{params[:user][:email]}, is already taken."
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
        format.json { respond_with_bip(@user) }
      end
    elsif !params[:user][:password].present?
      @profile = @user.profile
      if @user.update_attributes!(user_params)
        @user.roles.update_all(mobile_phone_number: @user.mobile_phone_number)
        flash[:success] = "Updated successfully."
        respond_to do |format|
          format.html {redirect_to :back}
          format.js
          format.json { respond_with_bip(@user) }
        end
      else
        flash[:error] = "Error."
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

  def email
    @user = User.friendly.find(params[:user_id])
    if @user.email.present?
      redirect_to edit_user_path(@user)
    else

    end
  end

  def update_email
  end

  def email_check
    number = params[:number].to_s.gsub(/[^\d]/, "")
    email = params[:email].to_s.downcase
    if number.present? || email.present?
      conditions = []
      conditions << "mobile_phone_number = '#{number}'" if number.present?
      conditions << "email = '#{email}'" if email.present?
      @users = User.where(conditions.join(" or "))
      if current_user.present? && params[:type] != "other"
        if @users.include? current_user
          user_exists = false
        else
          user_exists = @users.present?
        end
      else
        user_exists = @users.present?
      end
    end
    if user_exists
      error_message = number.present? ? 'Number' : 'Email'
      error_message += " already taken"
    end
    respond_to do |format|
      format.json { render json: { error: error_message }, status: user_exists ? 422 : 200 }
    end
  end

  protected

  def user_params
    params.require(:user).permit({:team_ids => []}, :prefix, :name, :first_name, :middle_name, :last_name, :suffix, :email, :username,:mobile_phone_number,  :password, :password_confirmation, :current_password, {profile_attributes: [:id, :user_id, :instagram, :twitter, :facebook, :linkedin, :hudl, :youtube, :pinterest, :foursquare, :description, :date_of_birth, :favorite_pro_team, :favorite_college_team, :favorite_pro_athlete, :mobile_phone_number, :undergraduate_school, :graduate_school, :doctorate_school, :undergraduate_major, :graduate_major, :doctorate_major, :undergraduate_year, :graduate_year, :doctorate_year, :undergraduate_degree, :graduate_degree, :doctorate_degree, :height_ft, :height_in, :weight, :sex, :team, :league, :primary_position, :secondary_position, :level, :guardian, :guardian_phone_number, :company, :title, :website, :agency, :industries, :interests, :skills, :city, :offseason_city, :state, :zipcode, {sports: []}, {skills: []}, {specialties: []}, {injuries: []}, {current_ailments: []}, {focus: []}, :category, :mobile_phone_number ]},  {user_profile_pictures_attributes: [:id, :user_id, :photo]}, {user_addresses_attributes: [:id, :user_id, :street_1, :street_2, :city, :state, :country, :zip, :apt_no]} )
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
