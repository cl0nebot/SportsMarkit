class SendEmail < ActionMailer::Base
  def new_registration(user)
    @user = user
    mail(from: "donotreply@sportsmarkit.com", to: @user.email, subject: "New Registration")
  end

  def certificate_expiration(user, message="")
    @user = user
    @message = message
    mail(from: "donotreply@sportsmarkit.com", to: @user.email, subject: "Certification expiration")
  end

  def password_reset(user)
    @user = user
    mail(from: "donotreply@sportsmarkit.com", to: @user.email, subject: "SportsMarkit Password Reset")
  end

  def send_contact_message(message)
    @message = message
    mail(from: "donotreply@sportsmarkit.com", to: "info@sportsmarkit.com", subject: "You've received a message from a SportsMarkit user.")
  end

  def notify_user_of_admin_role(user, role, entity)
    @user = user
    @entity = entity
    @role = role
    @message = "#{@user.full_name}, you are now a(n) #{@role} for #{@entity.name}"
    mail(from: "donotreply@sportsmarkit.com", to: "info@sportsmarkit.com", subject: @message)
  end

  def send_announcement_message(object, current_user, user, message)
    @user = user
    @message = message
    @object = object
    @sender = current_user
    mail(from: "#{@sender.first_name} via SportsMarkit <donotreply@sportsmarkit.com>", to: user.email, subject: "Message from #{@object.proper_name}")
  end
end
