class Sport < ActiveRecord::Base
  has_many :sport_photos #TODO dependent destroy?
  accepts_nested_attributes_for :sport_photos, :reject_if => :all_blank, :allow_destroy => true
  
  def default_photo
    sport_photos.last.photo
  end
end
