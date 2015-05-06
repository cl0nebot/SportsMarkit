class SportPhoto < ActiveRecord::Base
  mount_uploader :photo, ImageUploader

  belongs_to :sport
  validates :photo, presence: true

  after_create :delete_existing_sport_photo

  def delete_existing_sport_photo
    owner = self.sport
    if owner.sport_photos.count > 1
      owner.sport_photos.first.delete
    end
  end
  
  
end
