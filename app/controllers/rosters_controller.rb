class RostersController < ApplicationController
  require 'twilio-ruby'

  def create
    variables
    @valid_phone_number = @mobile_number.present? ? @mobile_number =~ /\d{3}-\d{3}-\d{4}/ : true
    Rails.logger.info("Phone number is invalid.") unless @valid_phone_number
    if @array.compact.blank? || !!@valid_phone_number
      Rails.logger.info("Phone number is valid.") if @valid_phone_number
      @mobile_number.present? ? (@user_exists ? add_existing_user_to_roster : create_new_user_and_roster_spot) : create_userlesss_roster_spot
      Rails.logger.info("User already exists") if @user_exists
    end
  end

  def accept
    user_id = params[:user_id]
    roleable_type = params[:roleable_type]
    roleable_id = params[:roleable_id]
    athlete = params[:athlete].present? ? "Athlete" : nil
    coach = params[:coach].present? ? "Coach" : nil
    parent = params[:parent].present? ? "Guardian" : nil
    manager = params[:manager].present? ? "Team Manager" : nil
    trainer = params[:trainer].present? ? "Trainer" : nil
    admin = params[:admin].present? ? "Admin" : nil
    @blank = [athlete, coach, parent, manager, trainer, admin].compact.blank?
    p @blank
    unless @blank
      Role.where(user_id: user_id, roleable_type: roleable_type, roleable_id: roleable_id, status: "Pending").destroy_all
      [athlete, coach, parent, manager, trainer, admin].compact.each do |role|
        role = Role.create(user_id: user_id, roleable_type: roleable_type, roleable_id: roleable_id, status: "Active", role: role)
        SendEmail.notify_user_of_admin_role(User.find(role.user_id), role.role, role.roleable_type.constantize.find(role.roleable_id))
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

  def find_user
    @user = User.find(params[:user_id])
    @team = Team.find(params[:team_id])
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end

  def update
    athlete = params[:athlete].present? ? "Athlete" : nil
    coach = params[:coach].present? ? "Coach" : nil
    parent = params[:parent].present? ? "Guardian" : nil
    manager = params[:manager].present? ? "Team Manager" : nil
    trainer = params[:trainer].present? ? "Trainer" : nil
    admin = params[:admin].present? ? "Admin" : nil

    add = ["Coach", "Team Manager", "Trainer", "Admin"] & [coach, manager, trainer, admin].compact
    remove = ["Coach", "Team Manager", "Trainer", "Admin"] - [coach, manager, trainer, admin].compact
    @object = params[:object_type].constantize.find(params[:id])
    if @object.class == Role
      title = params[:role][:title]
      @user_id = @object.user_id
      @team = @object.roleable
      roleable_type = @team.class.to_s
      roleable_id = @team.id

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
    else
      title = params[:userless_role][:title]
      @first_name = @object.first_name
      @last_name = @object.last_name
      @team = Team.find(params[:team_id])
      userless_type = @team.class.to_s
      userless_id = @team.id
      unless params[:member].present?
        add.compact.each do |role_name|
          userless_role = UserlessRole.where(first_name: @first_name, last_name: @last_name, userless_type: userless_type, userless_id: userless_id, role: role_name).first_or_create
          userless_role.update_attributes(status: "Active", title: title )
        end
        remove.compact.each do |role_name|
          userless_role = UserlessRole.where(first_name: @first_name, last_name: @last_name, userless_type: userless_type, userless_id: userless_id, role: role_name).last.try(:delete)
        end
        respond_to do |format|
          format.js
          format.html { redirect_to :back }
        end
      else
        @object.update_attributes(role_or_userless_role_params)
      end
    end
  end

  def destroy
    @class = params[:class]
    @id = params[:id]
    role_or_userless_role = @class.constantize
    if params[:roster_spot] == "Athlete"
      role_or_userless_role.find(@id).destroy
    elsif params[:roster_spot] == "Head"
      object = role_or_userless_role.find(@id)
      if @class == "Role"
        objects = Role.where(user_id: object.user_id , status: "Active", roleable_type: "Team", roleable_id: params[:team_id], role: ["Coach", "Team Manager", "Trainer", "Admin"] )
      else
        objects = UserlessRole.where(first_name: object.first_name , last_name: object.last_name , role: ["Coach", "Team Manager", "Trainer", "Admin"], status: "Active", userless_type: "Team", userless_id: params[:team_id])
      end
      objects.destroy_all
    end
  end

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
    @array << coach = params[:coach].nil? ? nil : "Coach"
    @array << athlete = params[:athlete].nil? ? nil : "Athlete"
    @array << admin = params[:admin].nil? ? nil : "Admin"
    @array << trainer = params[:trainer].nil? ? nil : "Trainer"
    @array << manager = params[:manager].nil? ? nil : "Team Manager"
    @nickname = params[:nickname]
    @position_ids = params[:position_ids]
    @jersey = params[:jersey_number]
  end

  def add_existing_user_to_roster
    @existing_user = User.find_by_mobile_phone_number(@mobile_number)
    if @existing_user.roles.where(roleable_type: "Team", roleable_id: @team.id).present?
    else
      Role.create_new_roles(@existing_user.id, @array, params)
    end
  end

  def create_new_user_and_roster_spot
    User.create_new_user_and_roster_spot(@first_name, @last_name, @mobile_number, @array, params)
  end

  def create_userlesss_roster_spot
    UserlessRole.create_new_roles(@array, params)
  end

  def send_mobile_invitation(user, password)
    receiving_number = user.mobile_phone_number
    Rails.logger.info("Sending text message to #{user.mobile_phone_number}")

    twilio_sid = ENV['TWILIO_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = "2027590519"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    begin
      @twilio_client.account.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => receiving_number,
        :body => "#{user.first_name}, Coach #{current_user.last_name.capitalize} has created your new team hub!

http://www.sportsmarkit.com/login
Login: #{user.mobile_phone_number}
Password: #{password}"
      )
    rescue Twilio::REST::RequestError => e
      puts e.message
    end
  end

  def role_or_userless_role_params
    if params[:object_type] == "Role"
      params.require(:role).permit(:role, :roleable_id, :roleable_type, :date_added, :accepting_user_id, :status, :mobile_phone_number, :level, :nickname, :jersey_number, :title, position_ids: [])
    elsif params[:object_type] == "UserlessRole"
      params.require(:userless_role).permit(:first_name, :last_name, :role, :roleable_id, :roleable_type, :date_added, :accepting_user_id, :status, :roleable_type, :level, :nickname, :jersey_number, :title, position_ids: [])
    end
  end
end
