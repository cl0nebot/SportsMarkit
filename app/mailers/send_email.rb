class SendEmail < ActionMailer::Base
 
  
  
  # reset password
  
  def password_reset(user)
    @user = user
    mail(from: "donotreply@sportsmarkit.com", to: @user.email, subject: "SportsMarkit Password Reset")
  end
  
  
  
end
