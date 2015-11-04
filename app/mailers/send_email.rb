class SendEmail < ActionMailer::Base
 
  
  
  # reset password
  
  def password_reset(user)
    @user = user
    mail(from: "donotreply@sportsmarkit.com", to: @user.email, subject: "SportsMarkit Password Reset")
  end
  
  def send_contact_message(message)
    @message = message
    mail(from: "donotreply@sportsmarkit.com", to: "info@sportsmarkit.com", subject: "You've received a message from a SportsMarkit user.")
  end
  
  
  
end
