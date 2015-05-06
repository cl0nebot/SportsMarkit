class SportIcon < ActiveRecord::Base
  mount_uploader :icon, ImageUploader

  belongs_to :sport
  validates :icon, presence: true

  after_create :delete_existing_sport_icon

  def delete_existing_sport_icon
    owner = self.sport
    if owner.sport_icons.count > 1
      owner.sport_icons.first.delete
    end
  end
  
end
