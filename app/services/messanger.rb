module Messanger
  extend self

  def send_sms(receiving_number, body, force = false)
    return unless force || Rails.env.production?

    log_sending(receiving_number)

    begin
      twillio_client.account.messages.create(:from => "+1#{twilio_phone_number}", to: receiving_number, body: body)
    rescue Twilio::REST::RequestError => e
      log_error(number, e)
    end
  end

  def log_sending(number)
    logger.info("Sending sms to #{number}")
  end

  def log_error(number, e)
    logger.info("Error when attempting to send sms to  #{number}: #{e.message}")
  end

  def logger
    @logger ||= Rails.logger
  end

  def twillio_phone_number
    "2027590519"
  end

  def twillio_client
    @twillio_client ||= Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH_TOKEN']
  end
end