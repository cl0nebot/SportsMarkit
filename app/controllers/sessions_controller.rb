class SessionsController < ApplicationController
  require 'twilio-ruby'


  respond_to :html, :json

  def new
    if current_user
      redirect_to root_path
    end
  end

  def create
    user = User.where(email: params[:identifier]).first if params[:identifier].include?("@")
    user = User.where(mobile_phone_number: params[:identifier]).first unless params[:identifier].include?("@")
    if user && user.authenticate(params[:password])
      cookies.permanent[:authentication_token] = user.authentication_token
      if user.email.blank? and user.mobile_phone_number.present?
        redirect_to user_email_path(user)
      else
        if user.signin_count < 1 or user.classifications.blank?
          if user.mobile_phone_number.present? && Relationship.where(user_id: user.id, mobile_phone_number: user.mobile_phone_number)
            send_mobile_notification(user)
          end
          user.increment!(:signin_count)
          redirect_to user_overview_path(user)
        else
          user.increment!(:signin_count)
          redirect_to edit_user_path(user)
        end 
      end
    else
      flash[:error] = "Email or password is incorrect."
      redirect_to :back
    end
  end

  def show;end

  def destroy
    cookies.delete(:authentication_token)
    redirect_to root_url
  end

  def check_email
    user = User.where( email: params[:email] ).first
    result = {}
    result[:available] = user.nil?
    if user
      result[:name] = user.full_name
    end
    respond_to do |format|
      format.json { render json: result }
    end
  end
  
  def send_mobile_notification(user)
    relationship_ids = user.relationships.pluck(:team_id)
    coach_user_ids = Relationship.where(team_id: relationship_ids, head: true, accepted: true).pluck(:user_id)
    
    User.where(id: coach_user_ids).each do |coach|
      
      receiving_number = coach.mobile_phone_number

      twilio_sid = ENV['TWILIO_SID']
      twilio_token = ENV['TWILIO_AUTH_TOKEN']
      twilio_phone_number = "2027590519"

      @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

      @twilio_client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => receiving_number,
        :body => "Coach, #{user.first_name} has joined your SportsMarkit team!" )
      end
  end
  
  
  
  
end
