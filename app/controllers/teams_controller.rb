class TeamsController < ApplicationController
  before_action :find_team, only: [:show, :edit, :update, :destroy]
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
    if params[:school_id]
      @school = School.friendly.find(params[:school_id])
      @team = @school.teams.build
    else
      @team = Team.new
    end
  end
  
  def create    
    if request.referrer.split("/")[3] == "schools"
      @school = School.find_by_slug(request.referrer.split("/")[4])
      @team = @school.teams.build(team_params)
      if @team.save
        redirect_to "/teams/#{@team.slug}"
      else
        render 'new'
      end
    else
      @team = Team.new(team_params)
      if @team.save
        redirect_to teams_path
      else
        render 'new'
      end
    end
  end
  
  def create_roster_spot
    @team = Team.friendly.find(params[:id])
    mobile_number = params[:mobile_phone_number]
    user_exists = User.exists?(mobile_phone_number: mobile_number)
    fname = params[:first_name]
    lname = params[:last_name]
    title = params[:title]
    position = params[:position]
    classification = params[:participant_classification]
    head = params[:head].nil? ? true : false
    participant = params[:participant].nil? ? true : false
    
    if mobile_number.present? # if a phone number is provided in the form
      if user_exists # check to see if a user exists on the site with that phone number
        user = User.find_by_mobile_phone_number(mobile_number) # if yes, find user
        if user.relationships.exists?(team_id: @team.id)  # check to see if that user already has a relationship with team
          flash[:error] = "User is on roster already" # if so, don't submit.
          redirect_to :back
        else
          Relationship.create(team_id: @team.id, user_id: user.id, accepted: true, head: head, participant: participant, mobile_phone_number: mobile_number, participant_classification: classification, position: position) # if user exists, but relationship does not, create relationship
        end
      else # if user doesn't exist with that mobile number, create
        password = generate_temporary_password(fname)
        @new_user = User.new(first_name: fname, last_name: lname, mobile_phone_number: mobile_number, password: password)
        if @new_user.save
          Profile.create(user_id: @new_user.id, focus: [], specialties: [], skills: [], injuries: [], current_ailments: [])
          @relationship = Relationship.create(user_id: @new_user.id, team_id: @team.id, accepted: true, mobile_phone_number: mobile_number, head: head, participant: participant, participant_classification: classification, position: position )
          if @team.school.present?
            Classification.create(user_id: @new_user.id, classification: "Student Athlete")
          else
            Classification.create(user_id: @new_user.id, classification: "Athlete")
          end
          if @relationship.head?
            Classification.create(user_id: @new_user.id, classification: "Coach")
          end
          send_mobile_invitation(@new_user, password)
          redirect_to :back
        else
          # user not saved
          redirect_to :back
        end
      end
    else #mobile not present
      UserlessRelationship.create(first_name: fname, last_name: lname, team_id: @team.id, head: head, participant: participant, participant_classification: classification, position: position)
      redirect_to :back
    end
  end
  
  def show
    @members = @team.relationships.where(accepted: true, participant: true) + UserlessRelationship.where(team_id: @team.id, participant: true)
    @athletes = @team.relationships.where(accepted: true, head: false)
    @pending_members = @team.relationships.where(accepted: nil, rejected: nil)
    @heads = @team.relationships.where(accepted: true, head: true) + UserlessRelationship.where(team_id: @team.id, head: true)
    @class = @team.class
    @object = @team
    @events = @team.upcoming_events
    @facilities = @team.facilities
    @new_user = User.new
    @relationship = @new_user.relationships.build
    @event = @object.events.build
    @videos = @team.medias.where(category: "Video")
    @articles = @team.medias.where(category: "Article")
    
  end
  
  def accept_user
    @relationship = Relationship.find_by_slug(params[:id])
    @relationship.update_attributes(accepted: true)
    if @team.school.present?
      Classification.create(user_id: @new_user.id, classification: "Student Athlete")
    else
      Classification.create(user_id: @new_user.id, classification: "Athlete")
    end
    if @relationship.head?
      Classification.create(user_id: @new_user.id, classification: "Coach")
    end
    # @pending_relationships = Relationship.where(team_id: @relationship.team_id, accepted: nil, rejected: nil)
    # @relationships = Relationship.where(team_id: @relationship.team_id, accepted: true)
    respond_to do |format|
      format.js 
      format.html { redirect_to :back }
    end
  end

  def reject_user
    @relationship = Relationship.find_by_slug(params[:id])
    @relationship.update_attribute(:rejected, true)
    # @pending_relationships = Relationship.where(team_id: @relationship.team_id, accepted: nil, rejected: nil)
    # @relationships = Relationship.where(team_id: @relationship.team_id, accepted: true)
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  
  def edit_roster_view
    @id = params[:id]
    @team = Team.find(params[:team_id])
    @class = params[:class]
    @object = @class.constantize.send("find", @id)
  end
  
  def close_roster_view
    @id = params[:id]
    @team = Team.find(params[:team_id])
    @class = params[:class]
    @object = @class.constantize.send("find", @id)
  end

  def edit
    @object = @team
  end
  
  def update
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
  
  def find_team
    @team = Team.friendly.find(params[:id])
  end
  
  def team_params
    params.require(:team).permit(:name, :sport, :school_id, :league_id, :classification, :abbreviation, :address_1, :address_2, :city, :state, :zip, :zip_ext, :latitude, :longitude, :gmaps, :phone_number, :email, :website, :slug)
  end
  
  def user_params
    params.require(:user).permit(:prefix, :first_name, :middle_name, :last_name, :suffix, :email, :username,  :password, :password_confirmation, :current_password, :mobile_phone_number, {relationships_attributes: [:id, :user_id, :team_id, :head, :head_title, :mobile_phone_number, :position, :participant, :participant_classification, :username ]})
  end
  
  def send_mobile_invitation(user, password)
    receiving_number = user.mobile_phone_number

    twilio_sid = ENV['TWILIO_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = "2025179077"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => receiving_number,
      :body => "#{user.first_name}, Coach #{current_user.last_name.capitalize} has created your new team hub! 
      
http://www.teamnation.io 
Login: #{user.mobile_phone_number} 
Password: #{password}"
    )
  end
end

