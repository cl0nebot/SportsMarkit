class Photo < ActiveRecord::Base
  belongs_to :photo_owner, polymorphic: true

  mount_uploader :image, PhotoUploader
  crop_uploaded :image

  scope :main, ->{ where(main: true) }
end