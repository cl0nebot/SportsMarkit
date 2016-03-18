namespace :certification do
  desc "Notify users about sertification expirations"
  task :notify_expiration => :environment do
    CertificationExpirationService.call
  end
end
