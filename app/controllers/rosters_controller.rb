class RostersController < ApplicationController
  require 'twilio-ruby'
  
  def create
    variables
    @mobile_number.present? ? (@user_exists ? add_existing_user_to_roster : create_new_user_and_roster_spot) : create_userlesss_roster_spot
  end
  
  def update
    @id = params[:id]
    @role = params[:object_type].constantize.find(@id)
    @team = @role.roleable
    @object = @role
    @role.update_attributes(role_or_userless_role_params)
    @members = @team.all_athlete_roles
    @heads = @team.staff_roles
    @accepting_action = true # params[:roster][:accepted].nil? ? false : true
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  
  
  

  
  
  
  # def accept_user
  #   admin = params[:relationship][:admin] == "1" ? true : false
  #   head = params[:relationship][:head] == "1" ? true : false
  #   participant = params[:relationship][:participant] == "1" ? true : false
  #   @relationship = Relationship.find(params[:relationship_id])
  #   @relationship.update_attributes(accepted: true, admin: admin, head: head, participant: participant)
  #   @team = Team.find(@relationship.team_id)
  #   staff_relationships = @team.relationships.where(accepted: true, head: true) + @team.relationships.where(accepted: true, trainer: true) + @team.relationships.where(accepted: true, manager: true)
  #   staff_userless_relationships = UserlessRelationship.where(team_id: @team.id, head: true) + UserlessRelationship.where(team_id: @team.id, trainer: true) + UserlessRelationship.where(team_id: @team.id, manager: true)
  #   @heads = staff_relationships.uniq + staff_userless_relationships.uniq
  #   @members = @team.relationships.where(accepted: true, participant: true) + UserlessRelationship.where(team_id: @team.id, participant: true)
  #   @admins = @team.relationships.where(accepted: true, admin: true) + UserlessRelationship.where(team_id: @team.id, admin: true)
  #   if @team.school.present?
  #     Classification.where(user_id: @relationship.user_id, classification: "Student Athlete").first_or_create
  #   else
  #     Classification.where(user_id: @relationship.user_id, classification: "Athlete").first_or_create
  #   end
  #   if @relationship.head?
  #     Classification.where(user_id: @relationship.user_id, classification: "Coach").first_or_create
  #   end
  #   # @pending_relationships = Relationship.where(team_id: @relationship.team_id, accepted: nil, rejected: nil)
  #   # @relationships = Relationship.where(team_id: @relationship.team_id, accepted: true)
  #   respond_to do |format|
  #     format.js
  #     format.html { redirect_to :back }
  #   end
  # end
  #
  # def reject_user
  #   @relationship = Relationship.find(params[:id])
  #   @relationship.destroy
  #   # @pending_relationships = Relationship.where(team_id: @relationship.team_id, accepted: nil, rejected: nil)
  #   # @relationships = Relationship.where(team_id: @relationship.team_id, accepted: true)
  #   respond_to do |format|
  #     format.js
  #     format.html { redirect_to :back }
  #   end
  # end


  def edit_roster_view
    @id = params[:id]
    @team = Team.find(params[:roster_id])
    @class = params[:class]
    @object = @class.constantize.send("find", @id)
  end

  def close_roster_view
    @id = params[:id]
    @team = Team.find(params[:roster_id])
    @class = params[:class]
    @object = @class.constantize.send("find", @id)
  end
  
  
  private
  
  def variables
    @team = Team.friendly.find(params[:team_id])
    @mobile_number = params[:mobile_phone_number]
    @user_exists = User.exists?(mobile_phone_number: @mobile_number)
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @title = params[:title]
    @level = params[:level]
    @array = []
    @array << coach = params[:head].nil? ? nil : "Coach"
    @array << athlete = params[:athlete].nil? ? nil : "Athlete"
    @array << admin = params[:admin].nil? ? nil : "Admin"
    @array << trainer = params[:trainer].nil? ? nil : "Trainer"
    @array << manager = params[:manager].nil? ? nil : "Manager"
    @nickname = params[:nickname]
    @position_ids = params[:position_ids]
    @jersey = params[:jersey_number]
  end
  
  def add_existing_user_to_roster
    @existing_user = User.find_by_mobile_phone_number(@mobile_number) 
    if @existing_user.roles.where(roleable_type: "Team", roleable_id: @team.id).present? 
      redirect_to :back, flash[:error] = "User is on roster already" 
    else
      Role.create_new_role(@existing_user.id, @array, params)
      redirect_to :back   
    end
  end
  
  def generate_password
    @password = generate_temporary_password(@first_name)
  end
  
  def create_new_user_and_roster_spot
    generate_password
    @new_user = User.new(first_name: @first_name, last_name: @last_name, mobile_phone_number: @mobile_number, password: @password)
    if @new_user.save
      @new_user.create_profile
      Role.create_new_role(@new_user.id, @array, params)
      send_mobile_invitation(@new_user, @password)
    end
    redirect_to :back
  end
  
  def create_userlesss_roster_spot
    UserlessRole.create_new_role(@array, params)
    redirect_to :back
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
  
  def role_or_userless_role_params
    if params[:object_type] == "Role"
      params.require(:role).permit(:role, :roleable_id, :roleable_type, :date_added, :accepting_user_id, :status, :mobile_phone_number, :level, :nickname, :jersey_number, :title)
    elsif params[:object_type] == "UserlessRole"
      params.require(:userless_role).permit(:first_name, :last_name, :role, :roleable_id, :roleable_type, :date_added, :accepting_user_id, :status, :roleable_type, :level, :nickname, :jersey_number, :title)
    end
  end
  
  
end



