class RostersController < ApplicationController
  require 'twilio-ruby'
  
  def create
    variables
    @blank = @array.compact.blank?
    unless @blank
      @mobile_number.present? ? (@user_exists ? add_existing_user_to_roster : create_new_user_and_roster_spot) : create_userlesss_roster_spot
    end
  end
  
  # def update
  #
  #   @team = @object.roleable
  #   @object.update_attributes(role_or_userless_role_params)
  #   @members = @team.all_athlete_roles
  #   @heads = @team.staff_roles
  #
  #   respond_to do |format|
  #     format.js
  #     format.html { redirect_to :back }
  #   end
  # end
  
  def accept
    user_id = params[:user_id]
    roleable_type = params[:roleable_type]
    roleable_id = params[:roleable_id]
    athlete = params[:athlete].present? ? "Athlete" : nil
    coach = params[:coach].present? ? "Coach" : nil
    parent = params[:parent].present? ? "Parent" : nil
    manager = params[:manager].present? ? "Manager" : nil
    trainer = params[:trainer].present? ? "Trainer" : nil
    admin = params[:admin].present? ? "Admin" : nil
    @blank = [athlete, coach, parent, manager, trainer, admin].compact.blank?
    p @blank
    unless @blank 
      Role.where(user_id: user_id, roleable_type: roleable_type, roleable_id: roleable_id, status: "Pending").destroy_all
      [athlete, coach, parent, manager, trainer, admin].compact.each do |role|
        role = Role.create(user_id: user_id, roleable_type: roleable_type, roleable_id: roleable_id, status: "Active", role: role)
        SendEmail.notify_user_of_admin_role(User.find(role.user_id), role.role, role.roleable_type.constantize.find(role.roleable_id)  
      end
       
    end
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  def reject
    @object = Role.find(params[:id])
    @object.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  #Parameters: {"utf8"=>"✓", "authenticity_token"=>"c9leG2pZ+ByyH1nxaILKu1av2lDp5GLriI/z4E0PHmk=", "close_admin"=>"true", "role"=>{"title"=>""}, "coach"=>"true", "commit"=>"Update Team Member", "object_type"=>"Role", "id"=>"21319"}
  
  def update
    @object = params[:object_type].constantize.find(params[:id])
    @user_id = @object.user_id
    @team = @object.roleable
    #@accepting_action = true # params[:roster][:accepted].nil? ? false : true
    roleable_type = @team.class.to_s
    roleable_id = @team.id
    title = params[:role][:title]
    
    athlete = params[:athlete].present? ? "Athlete" : nil
    coach = params[:coach].present? ? "Coach" : nil
    #parent = params[:parent].present? ? "Parent" : nil
    manager = params[:manager].present? ? "Manager" : nil
    trainer = params[:trainer].present? ? "Trainer" : nil
    admin = params[:admin].present? ? "Admin" : nil
    
    add = ["Coach", "Manager", "Trainer", "Admin"] & [coach, manager, trainer, admin].compact
    remove = ["Coach", "Manager", "Trainer", "Admin"] - [coach, manager, trainer, admin].compact
    
    unless params[:member].present?
      add.compact.each do |role_name|
        role = Role.where(user_id: @user_id, roleable_type: roleable_type, roleable_id: roleable_id, role: role_name).first_or_create
        role.update_attributes(status: "Active", title: title )
      end
      remove.compact.each do |role_name|
        role = Role.where(user_id: @user_id, roleable_type: roleable_type, roleable_id: roleable_id, role: role_name).last.try(:delete)
      end
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    else
      @object.update_attributes(role_or_userless_role_params)
    end
  end
  
  # def update
  #   @relationship = Relationship.find(params[:id])
  #   @team = @relationship.team
  #   @class = @relationship.class.to_s
  #   @id = params[:id]
  #   @object = @relationship
  #   @relationship.update_attributes(relationship_params)
  #   @members = @team.relationships.where(accepted: true, participant: true) + UserlessRelationship.where(team_id: @team.id, participant: true)
  #   staff_relationships = @team.relationships.where(accepted: true, head: true) + @team.relationships.where(accepted: true, trainer: true) + @team.relationships.where(accepted: true, manager: true)
  #   staff_userless_relationships = UserlessRelationship.where(team_id: @team.id, head: true) + UserlessRelationship.where(team_id: @team.id, trainer: true) + UserlessRelationship.where(team_id: @team.id, manager: true)
  #   @heads = staff_relationships.uniq + staff_userless_relationships.uniq
  #   @accepting_action = params[:relationship][:accepted].nil? ? false : true
  #   respond_to do |format|
  #     format.js
  #     format.html { redirect_to :back }
  #   end
  # end
  #
  #
  # def destroy
  #   @relationship = Relationship.find(params[:id])
  #   @team = @relationship.team
  #   @class = @relationship.class.to_s
  #   @id = params[:id]
  #   @object = @relationship
  #   @relationship.destroy
  #   @members = @team.relationships.where(accepted: true, participant: true) + UserlessRelationship.where(team_id: @team.id, participant: true)
  #   staff_relationships = @team.relationships.where(accepted: true, head: true) + @team.relationships.where(accepted: true, trainer: true) + @team.relationships.where(accepted: true, manager: true)
  #   staff_userless_relationships = UserlessRelationship.where(team_id: @team.id, head: true) + UserlessRelationship.where(team_id: @team.id, trainer: true) + UserlessRelationship.where(team_id: @team.id, manager: true)
  #   @heads = staff_relationships.uniq + staff_userless_relationships.uniq
  #   @admins = @team.relationships.where(accepted: true, admin: true) + UserlessRelationship.where(team_id: @team.id, admin: true)
  #   respond_to do |format|
  #     format.js
  #     format.html { redirect_to :back }
  #   end
  # end
  
  
  
  
  

  
  
  
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
  
  def create_new_user_and_roster_spot
    User.create_new_user_and_roster_spot(@first_name,@last_name, @mobile_number, @array)
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
      params.require(:role).permit(:role, :roleable_id, :roleable_type, :date_added, :accepting_user_id, :status, :mobile_phone_number, :level, :nickname, :jersey_number, :title, position_ids: [])
    elsif params[:object_type] == "UserlessRole"
      params.require(:userless_role).permit(:first_name, :last_name, :role, :roleable_id, :roleable_type, :date_added, :accepting_user_id, :status, :roleable_type, :level, :nickname, :jersey_number, :title, position_ids: [])
    end
  end
  
  
end

#
#
#
# class UserlessRelationshipsController < ApplicationController
#   require 'twilio-ruby'
#
#   def update
#     @userless_relationship = UserlessRelationship.find(params[:id])
#     @team = @userless_relationship.team
#     @class = @userless_relationship.class.to_s
#     @id = params[:id]
#     @object = @userless_relationship
#     mobile_number = params[:userless_relationship][:mobile_phone_number]
#     user_exists = User.exists?(mobile_phone_number: mobile_number)
#     fname = params[:userless_relationship][:first_name]
#     lname = params[:userless_relationship][:last_name]
#     title = params[:userless_relationship][:title]
#     position = params[:userless_relationship][:position]
#     classification = params[:userless_relationship][:participant_classification]
#     head = params[:userless_relationship][:head].nil? ? false : true
#     participant = params[:userless_relationship][:participant].nil? ? false : true
#     admin = params[:admin].nil? ? false : true
#     nickname = params[:nickname]
#     trainer = params[:trainer].nil? ? false : true
#     manager = params[:manager].nil? ? false : true
#     position_ids = params[:position_ids]
#     jersey = params[:jersey_number]
#     #if phone number present; remove userless, create real relationship and send invite
#
#     if mobile_number.present?
#       if user_exists # check to see if a user exists on the site with that phone number
#         user = User.find_by_mobile_phone_number(mobile_number) # if yes, find user
#         if user.relationships.exists?(team_id: @team.id)  # check to see if that user already has a relationship with team
#           flash[:error] = "User is on roster already" # if so, don't submit.
#         else
#           rel = Relationship.create(team_id: @team.id, user_id: user.id, accepted: true, head: head, participant: participant, mobile_phone_number: mobile_number, participant_classification: classification, position: position, admin: admin, nickname: nickname, trainer: trainer, manager: manager, jersey_number: jersey) # if user exists, but relationship does not, create relationship
#           position_ids.each do |i|
#             Positioning.create(position_id: i, positionable_id: rel.id, positionable_type: "Relationship")
#           end
#         end
#       else # if user doesn't exist with that mobile number, create
#         password = generate_temporary_password(fname)
#         @new_user = User.new(first_name: fname, last_name: lname, mobile_phone_number: mobile_number, password: password)
#         if @new_user.save
#           Profile.create(user_id: @new_user.id, focus: [], specialties: [], skills: [], injuries: [], current_ailments: [])
#           @relationship = Relationship.create(user_id: @new_user.id, team_id: @team.id, accepted: true, mobile_phone_number: mobile_number, head: head, participant: participant, participant_classification: classification, position: position, admin: admin, nickname: nickname, trainer: trainer, manager: manager, jersey_number: jersey)
#           position_ids.each do |i|
#             Positioning.create(position_id: i, positionable_id: @relationship.id, positionable_type: "Relationship")
#           end
#           if @team.school.present?
#             Classification.where(user_id: @new_user.id, classification: "Student Athlete").first_or_create
#           else
#             Classification.where(user_id: @new_user.id, classification: "Athlete").first_or_create
#           end
#           if @relationship.head?
#             Classification.where(user_id: @new_user.id, classification: "Coach").first_or_create
#           end
#           send_mobile_invitation(@new_user, password)
#           @userless_relationship.delete
#         else
#           # user not saved
#         end
#       end
#     else #mobile not present
#       @userless_relationship.update_attributes(userless_relationship_params)
#     end
#     respond_to do |format|
#       format.js
#       format.html { redirect_to :back }
#     end
#   end
#
#   def destroy
#     @userless_relationship = UserlessRelationship.find(params[:id])
#     @team = @userless_relationship.team
#     @class = @userless_relationship.class.to_s
#     @id = params[:id]
#     @object = @userless_relationship
#     @userless_relationship.destroy
#     @members = @team.relationships.where(accepted: true, participant: true) + UserlessRelationship.where(team_id: @team.id, participant: true)
#     staff_relationships = @team.relationships.where(accepted: true, head: true) + @team.relationships.where(accepted: true, trainer: true) + @team.relationships.where(accepted: true, manager: true)
#     staff_userless_relationships = UserlessRelationship.where(team_id: @team.id, head: true) + UserlessRelationship.where(team_id: @team.id, trainer: true) + UserlessRelationship.where(team_id: @team.id, manager: true)
#     @heads = staff_relationships.uniq + staff_userless_relationships.uniq
#     respond_to do |format|
#       format.js
#       format.html { redirect_to :back }
#     end
#   end
#
#   protected
#
#   def userless_relationship_params
#     params.require(:userless_relationship).permit({:position_ids => []}, :team_id, :first_name, :last_name, :head, :head_title, :jersey_number, :participant, :participant_classification, :position, :mobile_phone_number, :age, :nickname, :admin, :trainer, :manager)
#   end
#
#   def send_mobile_invitation(user, password)
#     receiving_number = user.mobile_phone_number
#
#     twilio_sid = ENV['TWILIO_SID']
#     twilio_token = ENV['TWILIO_AUTH_TOKEN']
#     twilio_phone_number = "2025179077"
#
#     @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
#
#     @twilio_client.account.sms.messages.create(
#       :from => "+1#{twilio_phone_number}",
#       :to => receiving_number,
#       :body => "#{user.first_name}, Coach #{current_user.last_name.capitalize} has created your new team hub!
#
# http://www.teamnation.io
# Login: #{user.mobile_phone_number}
# Password: #{password}"
#     )
#   end
# end





