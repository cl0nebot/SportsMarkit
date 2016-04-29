if Rails.env.production?
  Rails.application.config.middleware.use ExceptionNotification::Rack,
    :email => {
      :email_prefix => "[SPORTSMARKIT ERROR] ",
      :sender_address => %{"notifier" <notifier@example.com>},
      :exception_recipients => %w{accounts@wildfyregroup.com dmitri@wildfyregroup.com}
    }
end