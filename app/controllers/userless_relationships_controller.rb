class UserlessRelationshipsController < ApplicationController
  require 'twilio-ruby'
  
  def update
    @userless_relationship = UserlessRelationship.find(params[:id])
    @team = @userless_relationship.team
    @class = @userless_relationship.class.to_s
    @id = params[:id]
    @object = @userless_relationship
    mobile_number = params[:userless_relationship][:mobile_phone_number]
    user_exists = User.exists?(mobile_phone_number: mobile_number)
    fname = params[:userless_relationship][:first_name]
    lname = params[:userless_relationship][:last_name]
    title = params[:userless_relationship][:title]
    position = params[:userless_relationship][:position]
    classification = params[:userless_relationship][:participant_classification]
    head = params[:userless_relationship][:head].nil? ? false : true
    participant = params[:userless_relationship][:participant].nil? ? false : true
    admin = params[:admin].nil? ? false : true
    nickname = params[:nickname]
    trainer = params[:trainer].nil? ? false : true
    manager = params[:manager].nil? ? false : true
    position_ids = params[:position_ids]
    jersey = params[:jersey_number]
    #if phone number present; remove userless, create real relationship and send invite
    
    if mobile_number.present?
      if user_exists # check to see if a user exists on the site with that phone number
        user = User.find_by_mobile_phone_number(mobile_number) # if yes, find user
        if user.relationships.exists?(team_id: @team.id)  # check to see if that user already has a relationship with team
          flash[:error] = "User is on roster already" # if so, don't submit.
        else
          rel = Relationship.create(team_id: @team.id, user_id: user.id, accepted: true, head: head, participant: participant, mobile_phone_number: mobile_number, participant_classification: classification, position: position, admin: admin, nickname: nickname, trainer: trainer, manager: manager, jersey_number: jersey) # if user exists, but relationship does not, create relationship
          position_ids.each do |i|
            Positioning.create(position_id: i, positionable_id: rel.id, positionable_type: "Relationship")
          end
        end
      else # if user doesn't exist with that mobile number, create
        password = generate_temporary_password(fname)
        @new_user = User.new(first_name: fname, last_name: lname, mobile_phone_number: mobile_number, password: password)
        if @new_user.save
          Profile.create(user_id: @new_user.id, focus: [], specialties: [], skills: [], injuries: [], current_ailments: [])
          @relationship = Relationship.create(user_id: @new_user.id, team_id: @team.id, accepted: true, mobile_phone_number: mobile_number, head: head, participant: participant, participant_classification: classification, position: position, admin: admin, nickname: nickname, trainer: trainer, manager: manager, jersey_number: jersey)
          position_ids.each do |i|
            Positioning.create(position_id: i, positionable_id: @relationship.id, positionable_type: "Relationship")
          end
          if @team.school.present?
            Classification.create(user_id: @new_user.id, classification: "Student Athlete")
          else
            Classification.create(user_id: @new_user.id, classification: "Athlete")
          end
          if @relationship.head?
            Classification.create(user_id: @new_user.id, classification: "Coach")
          end
          send_mobile_invitation(@new_user, password)
          @userless_relationship.delete
        else
          # user not saved
        end
      end
    else #mobile not present
      @userless_relationship.update_attributes(userless_relationship_params)
    end
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end  
  end
  
  def destroy
    @userless_relationship = UserlessRelationship.find(params[:id])
    @team = @userless_relationship.team
    @class = @userless_relationship.class.to_s
    @id = params[:id]
    @object = @userless_relationship
    @userless_relationship.destroy
    @members = @team.relationships.where(accepted: true, participant: true) + UserlessRelationship.where(team_id: @team.id, participant: true)
    staff_relationships = @team.relationships.where(accepted: true, head: true) + @team.relationships.where(accepted: true, trainer: true) + @team.relationships.where(accepted: true, manager: true)
    staff_userless_relationships = UserlessRelationship.where(team_id: @team.id, head: true) + UserlessRelationship.where(team_id: @team.id, trainer: true) + UserlessRelationship.where(team_id: @team.id, manager: true)
    @heads = staff_relationships.uniq + staff_userless_relationships.uniq
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  protected
  
  def userless_relationship_params
    params.require(:userless_relationship).permit({:position_ids => []}, :team_id, :first_name, :last_name, :head, :head_title, :jersey_number, :participant, :participant_classification, :position, :mobile_phone_number, :age, :nickname, :admin, :trainer, :manager)  
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

