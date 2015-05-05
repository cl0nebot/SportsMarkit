class SportPhoto < ActiveRecord::Base
  mount_uploader :photo, ImageUploader
  mount_uploader :icon, ImageUploader

  belongs_to :sport
  validates :photo, :icon, presence: true

  # after_create :delete_existing_profile_picture
  #
  # def delete_existing_profile_picture
  #   owner = self.user
  #   if owner.sport_photos.count > 1
  #     owner.sport_photos.first.delete
  #   end
  # end
  
  
end
