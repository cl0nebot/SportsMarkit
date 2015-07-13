class NotificationsController < ApplicationController
  require 'twilio-ruby'
  
  def send_certification_reminder
    @user = User.find(params[:user_id])
    @certificate = Certificate.find(params[:cert_id])
    
    receiving_number = @user.mobile_phone_number
    twilio_sid = ENV['TWILIO_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = "2027590519"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => receiving_number,
      :body => "#{@user.first_name}, REMINDER: Your certification, #{@certificate.certification.name} is set to expire on #{@certificate.expiration}.")
  end
  
end
