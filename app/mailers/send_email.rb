class SendEmail < ActionMailer::Base
  default from: "from@example.com"
  
  
  # reset password
  
  def password_reset(user)
    @user = user
    mail(to: @user.email, subject: "Password Reset")
  end
  
  
  
end
