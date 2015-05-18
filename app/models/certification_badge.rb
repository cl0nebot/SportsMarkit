class CertificationBadge < ActiveRecord::Base
  mount_uploader :badge, ImageUploader

  belongs_to :certification
  validates :badge, presence: true

  after_create :delete_existing_certification_badge

  def delete_existing_certification_badge
    owner = self.certification
    if owner.certification_badges.count > 1
      owner.certification_badges.first.delete
    end
  end
  
end
