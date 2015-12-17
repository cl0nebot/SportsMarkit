class AnnouncementsController < ApplicationController
  require 'twilio-ruby'
  
  
  def index
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @object = $1.capitalize.constantize.find(params[param])
    @object_type = @object.class.to_s
    @objects = @object.announcements
    
  end
    
  def create
    @start_time = Time.now
    @user_group_is_not_selected = ((params[:specific_role_names].try(:first).try(:length).to_i > 1) || (params[:default_role_names].try(:first).try(:length).to_i > 1) ) ? false : true
    @delivery_method_is_not_selected = ((params[:sms].present?) || (params[:email].present?) ) ? false : true
    @sport_or_team_not_selected = @object.class.to_s == "Team" ? (((params[:sports].try(:first).try(:length).to_i > 1) || (params[:team_ids].try(:first).to_i != 0) ) ? false : true) : nil
    @character_limit_over = (params[:message].length > 480) ? true : false
    @characters_less_than_ten = (params[:message].length < 10) ? true : false
    unless [@user_group_is_not_selected, @delivery_method_is_not_selected, @sport_or_team_not_selected, @character_limit_over, @characters_less_than_ten].compact.include? true
      object = params[:object_type].constantize.find(params[:object_id])
    
  
      if params[:specific_role_names].try(:include?, "All")
        roles = object.class.custom_message_groups.collect { |r| r.gsub(" ", "_").downcase.pluralize}
      else
        roles = params[:specific_role_names].present? ? params[:specific_role_names].collect { |r| r.gsub(" ", "_").downcase.pluralize} : []
      end
      specific_array = []
        roles.each do |role|
          if role.length > 1
            object.send(role).each { |user| specific_array << user.id }
          end
        end
      specific_role_ids = specific_array.flatten #returns user ids for top level
    
      if params[:default_role_names].try(:include?, "All")
        roles = object.class.default_message_groups.collect { |r| r.gsub(" ", "_").downcase.singularize}
        p "the roles to use are #{roles}"
      else
        roles = params[:default_role_names].present? ? params[:default_role_names].collect { |r| r.gsub(" ", "_").downcase.singularize} : []
      end
      sports_team_ids = params[:sports] == ["All"] ? object.all_teams.pluck(:id) : object.all_teams.where(sport: params[:sports]).pluck(:id)
      specific_team_ids = params[:team_ids]
      all_team_ids = (sports_team_ids.to_a + specific_team_ids.to_a).uniq
      default_array = []
        roles.each do |role_type|
          if role_type.length > 1
            if object.class.to_s == "Team"
              default_array << object.send("#{role_type}_roles").pluck(:user_id)
              p "#{object.athlete_roles.pluck(:user_id)}"
            else
              object.send("#{role_type}_roles").where(roleable_type: "Team", roleable_id: all_team_ids).each { |role| default_array << role.user_id }
            end
          end
        end
      default_role_ids = default_array.flatten.flatten #returns user ids for team and sport filters
    
      p "Specific: #{specific_role_ids} | Default: #{default_role_ids.flatten.flatten}"
      p "Sports is All?: #{params[:sports] == ["All"]}"
      p "Sports Team IDs: #{sports_team_ids} | Specific Team IDs: #{specific_team_ids}"
      p "Default role: #{params[:default_role_names].collect { |r| r.gsub(" ", "_").downcase.singularize}}"
      
     
     
      users = User.where(id: (specific_role_ids + default_role_ids).uniq)
      @user_count = users.count
    
      # break message into 160 characters each
        str = params[:message]
        if params[:sms].present?
          users.each do |user|
            receiving_number = user.mobile_phone_number

            twilio_sid = ENV['TWILIO_SID']
            twilio_token = ENV['TWILIO_AUTH_TOKEN']
            twilio_phone_number = "2027590519"

            @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
            [str[0..159], str[160..319], str[320..479]].compact.each do |message|
            begin
              @twilio_client.account.sms.messages.create(
                :from => "+1#{twilio_phone_number}",
                :to => receiving_number,
                :body => "#{message}"
              )
              rescue Twilio::REST::RequestError => e
                puts e.message
              end
            end
          end 
        end
      
        if params[:email].present?
          users.each do |user|
            SendEmail.send_announcement_message(user, str).deliver
          end
        end
        
        
        @object = Announcement.create(user_id: current_user.id, announceable_type: object.class.to_s , announceable_id: object.id, message: params[:message], sports: params[:sports], team_ids: params[:team_ids], specific_user_groups: params[:specific_role_names] , default_user_groups: params[:default_role_names], sms: params[:sms].present?, email: params[:email].present?, subject: params[:subject] )
        
        @time_elapsed = (Time.now - @start_time)
      end
      respond_to do |format|
        format.js
        format.html {redirect_to :back}
      end
  end
  
  
  
  
  
end
