module CertificationExpirationService
  extend self

  def call
    send Certificate.expires_in(30), "Your certification will expire in 30 days"
    send Certificate.expires_in(15), "Your certification will expire in 15 days"
    send Certificate.expires_in(0), "Your certification expires today"
    send Certificate.expired, "Your certification expired"
  end

  def send(certs, message)
    certs.each do |cert|
      Messanger.send_sms(user_phone(cert), message)
      SendEmail.certificate_expiration(cert.user, message)
    end
  end

  def user_phone(cert)
    cert.user.mobile_phone_number
  end
end