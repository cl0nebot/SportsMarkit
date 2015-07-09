class Sport < ActiveRecord::Base
  has_many :sport_photos, dependent: :destroy
  accepts_nested_attributes_for :sport_photos, :reject_if => :all_blank, :allow_destroy => true
  has_many :sport_icons, dependent: :destroy
  accepts_nested_attributes_for :sport_icons, :reject_if => :all_blank, :allow_destroy => true
  
  has_many :league_sports, :dependent => :destroy
  has_many :leagues, :through => :league_sports
  
  def default_photo
    sport_photos.last.photo
  end

end
