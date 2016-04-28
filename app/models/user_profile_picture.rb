class UserProfilePicture < ActiveRecord::Base
  mount_uploader :photo, ImageUploader
  belongs_to :user, touch: true
  validates :photo, :presence => true
  
  after_create :delete_existing_profile_picture
  
  def delete_existing_profile_picture
    owner = self.user
    if owner.user_profile_pictures.count > 1
      owner.user_profile_pictures.first.delete
    end
  end
  
end