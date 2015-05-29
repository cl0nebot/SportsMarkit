class Photo < ActiveRecord::Base
  belongs_to :photo_owner, polymorphic: true

  mount_uploader :image, PhotoUploader
  crop_uploaded :image

  serialize :settings, Hashie::Mash

  scope :main, ->{ where(main: true) }

  delegate :offset_x, :offset_x=, :offset_y, :offset_y=, :zoom, :zoom=, to: :settings
end