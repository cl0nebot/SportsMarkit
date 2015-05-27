module PhotoOwner
  extend ActiveSupport::Concern

  included do
    has_many :photos, as: :photo_owner
    accepts_nested_attributes_for :photos
  end

  def main_photo
    photos.main.first_or_initialize
  end
end