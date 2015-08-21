module PhotoOwner
  extend ActiveSupport::Concern

  included do
    has_many :photos, as: :photo_owner
    accepts_nested_attributes_for :photos
    
    has_many :profile_pictures, dependent: :destroy, as: :profile_picture_owner
    accepts_nested_attributes_for :profile_pictures, :reject_if => :all_blank, :allow_destroy => true
  end

  def main_photo
    photos.main.first_or_initialize
  end
end