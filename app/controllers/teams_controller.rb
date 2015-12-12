class TeamsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :upgrade]
  before_action :correct_user!, only: [:edit, :destroy, :upgrade]
  before_action :find_teamable, only: [:new, :create]
  before_action :find_team, only: [:show, :edit, :destroy]
  require 'twilio-ruby'
  
  def index
    if params[:school_id]
      @school = School.friendly.find(params[:school_id])
      @teams = @school.teams.all
    else
      @teams = Team.all
    end
  end
  
  def new
    @teamable.present? ? @object = @teamable.teams.build : @object = Team.new
    @address = @object.build_address
  end
  
  def create 
    @team = @teamable.present? ? @teamable.teams.build(team_params) : Team.new(team_params)
    @team.teamable_id = @teamable.id if @teamable.present?
    @team.teamable_type = @teamable.class.to_s if @teamable.present?
    if @team.save
      Role.create(roleable_id: @team.id, roleable_type: "Team", status: "Active", role: "Admin", user_id: current_user.id) unless current_user.admin?
      [1,2,3].each { |i| Chatroom.create(team_id: @team.id, specific_id: i) }
      redirect_to @team
    else
      flash[:error] = "Oops."
      render 'new'
    end
  end
  
  def show
    @object = @team
    shared_variables
    @join_requests = @object.roles.where(status: "Pending")
    @members = @object.all_athlete_roles
    @admins = @object.all_admin_roles
    @athletes = @object.roles.athletes
    @pending_members = @object.pending_athlete_roles
    @heads = @object.staff_roles
    @facilities = @object.used_facilities
    @new_user = User.new
  end

  def edit
    @object = @team
    @picture =  @object.photos.build
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    profile_picture_insert
  end
  
  def update
    @object = Team.find_by_slug!(request.referrer.split("teams/").last.split("/").first)
    @profile_picture =  ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s).last
    @profile_pictures = ProfilePicture.where(profile_picture_owner_id: @object.id, profile_picture_owner_type: @object.class.to_s)
    @videos = @object.medias.where(category: "Video")
    @articles = @object.medias.where(category: "Article")
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    if @object.update_attributes(team_params)
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
    
  end
  
  def add_facility
    
  end
  
  def remove_facility
    
  end
  
  def join_league
    
  end
  
  def leave_league
    
  end
  
  protected
  
  def find_teamable
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @teamable = $1.capitalize.constantize.find(params[param]) rescue []
  end
  
  def find_team
    @team = Team.friendly.find(params[:id])
  end
  
  def team_params
    params.require(:team).permit(:name, :sport, :league_id, :classification, :description, :abbreviation, :phone_number, :email, :website, :slug, :facebook, :twitter, :linkedin, :pinterest, :instagram, :foursquare, :youtube, {address_attributes: [:id, :addressable_id, :addressable_type, :street_1, :street_2, :city, :state, :country, :postcode, :suite, :nickname, :default, :county, :latitude, :longitude, :gmaps]})  
  end
  
  def user_params
    params.require(:user).permit(:prefix, :first_name, :middle_name, :last_name, :suffix, :email, :username,  :password, :password_confirmation, :current_password, :mobile_phone_number, {relationships_attributes: [:id, :user_id, :team_id, :head, :head_title, :mobile_phone_number, :position, :jersey_number, :participant, :participant_classification, :username ]})
  end
    
  def send_mobile_invitation(user, password)
    receiving_number = user.mobile_phone_number

    twilio_sid = ENV['TWILIO_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = "2027590519"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => receiving_number,
      :body => "#{user.first_name}, Coach #{current_user.last_name.capitalize} has created your new team hub! 
      
http://www.sportsmarkit.com/login 
Login: #{user.mobile_phone_number} 
Password: #{password}"
    )
  end
end

