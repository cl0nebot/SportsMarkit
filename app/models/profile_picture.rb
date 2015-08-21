class ProfilePicture < ActiveRecord::Base
  mount_uploader :photo, ImageUploader
  belongs_to :profile_picture_owner, polymorphic: true
  validates :photo, :presence => true
  
  after_create :delete_existing_profile_picture
  
  def delete_existing_profile_picture
    owner = self.profile_picture_owner
    if owner.profile_pictures.count > 1
      owner.profile_pictures.first.delete
    end
  end
  
end
