class AnnouncementsService
  def initialize(announcementable, params, current_user)
    @announcementable = announcementable
    @params = params
    @current_user = current_user
  end

  def notify_users
    send_sms_to_users
    send_email_to_users
    announcement_users.size
  end

  def send_sms_to_users
    if @params[:sms].present?
      announcement_users.each do |user|
        Messanger.send_sms(user.mobile_phone_number,
          "#{user.first_name}, you have a message from #{@current_user.full_name}: #{@params[:message]}") if user.mobile_phone_number.present?
      end
    end
  end

  def send_email_to_users
    if @params[:email].present?
      announcement_users.each do |user|
        next if user.email.nil?
        SendEmail.send_announcement_message(@announcementable, @current_user, user, @params[:message]).deliver
      end
    end
  end

  def announcement_users
    @users ||= User.where(id: user_ids)
  end

  def user_ids
    user_ids_by_default_group + user_ids_by_custom_groups
  end

  def user_ids_by_default_group
    if @params[:default_user_groups].try(:include?, "All")
      roles = @announcementable.class.default_message_groups.collect { |r| r.gsub(" ", "_").downcase.singularize }
    else
      roles = @params[:default_user_groups].collect { |r| r.gsub(" ", "_").downcase.singularize }.reject(&:blank?)
    end

    roles.map do |role_type|
      if @announcementable.is_a? Team
        @announcementable.send("#{role_type}_roles").pluck(:user_id)
      else
        @announcementable.send("#{role_type}_roles").where(roleable_type: "Team", roleable_id: all_team_ids).map(&:user_id)
      end
    end.flatten
  end

  def user_ids_by_custom_groups
    if @params[:specific_user_groups].include? "All"
      roles = @announcementable.class.custom_message_groups.collect { |r| r.gsub(" ", "_").downcase.pluralize }
    else
      roles = @params[:specific_user_groups].collect { |r| r.gsub(" ", "_").downcase.pluralize }.reject(&:blank?)
    end

    roles.map do |role|
      @announcementable.send(role).map(&:id)
    end.flatten
  end

  def all_team_ids
    @all_team_ids ||= sport_team_ids + team_ids
  end

  def sport_team_ids
    @params[:sports] == ["All"] ? @announcementable.all_teams.pluck(:id) : @announcementable.all_teams.where(sport: @params[:sports]).pluck(:id)
  end

  def team_ids
    @params[:team_ids]
  end
end