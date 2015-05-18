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
    @new_user = User.new(user_params)
    @new_user.password = "testtest"
    if @new_user.save
      Profile.create(user_id: @new_user.id, focus: [], specialties: [], skills: [], injuries: [], current_ailments: [])
      Relationship.create(user_id: @new_user.id, team_id: @team.id, accepted: true, mobile_phone_number: @new_user.mobile_phone_number, head: params[:head], head_title: params[:head_title], participant_classification: params[:participant_classification], position: params[:position] )
      send_mobile_invitation(@new_user)
      redirect_to :back
    else
      redirect_to :back
    end
  end
  
  def show
    @members = @team.relationships.where(accepted: true)
    @athletes = @team.relationships.where(accepted: true, head: false)
    @pending_members = @team.relationships.where(accepted: nil, rejected: nil)
    @heads = @team.relationships.where(accepted: true, head: true)
    @class = @team.class
    @object = @team
    @events = @team.upcoming_events
    @facilities = @team.facilities
    @new_user = User.new
    @relationship = @new_user.relationships.build
    
  end
  
  def accept_user
    @relationship = Relationship.find_by_slug(params[:id])
    @relationship.update_attributes(accepted: true)
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

  def edit
    
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
    params.require(:team).permit(:name, :sport, :school_id, :league_id)
  end
  
  def user_params
    params.require(:user).permit(:prefix, :first_name, :middle_name, :last_name, :suffix, :email, :username,  :password, :password_confirmation, :current_password, :mobile_phone_number, {relationships_attributes: [:id, :user_id, :team_id, :head, :head_title, :mobile_phone_number, :position, :participant, :participant_classification ]})
  end
  
  def send_mobile_invitation(user)
    receiving_number = user.mobile_phone_number

    twilio_sid = ENV['TWILIO_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = "2025179077"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => receiving_number,
      :body => "Hello! This is FYE Sports. SMS messaging works for rosters. http://www.fyesports.com/welcome?m=#{receiving_number}"
    )
  end
end

