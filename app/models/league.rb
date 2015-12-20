class League < ActiveRecord::Base
  extend FriendlyId
  include Images
  include Shared
  include Roster
  include Map
  include ClassificationCount
  include EventDetail
  include Common
  include Access
  include Import
  
  friendly_id :use_for_slug, use: [:slugged, :finders]
  acts_as_gmappable
  has_one :address, as: :addressable, :dependent => :destroy
  accepts_nested_attributes_for :address, :reject_if => :all_blank, :allow_destroy => true
  
  has_many :roles, as: :roleable, dependent: :destroy
  has_many :userless_roles, as: :userless, dependent: :destroy
  
  has_many :facilities, as: :facility_owner
  has_many :team_leagues, dependent: :destroy
  has_many :events, as: :eventable
  
  has_many :league_sports, :dependent => :destroy
  has_many :sports, :through => :league_sports
  
  before_update :update_slug
  
  def minus_self
    Facility.where.not(id: id)
  end
  
  def use_for_slug
    existing_league = League.where('slug = ?', self.slug)
    if existing_league.present?
      "#{name} #{address.city_and_state} #{existing_league.count}"
    else
      "#{name} #{address.city_and_state}"
    end
  end
  
  def update_slug
    if (name_changed? || address.city_changed? || address.state_changed?)
      existing_league = self.minus_self.where('slug = ?', self.slug)
      if existing_league.present?
        update_column(:slug, "#{ApplicationController.helpers.to_slug(name, address.city_and_state, existing_league.count)}")
      else
        update_column(:slug, "#{ApplicationController.helpers.to_slug(name, address.city_and_state)}")
      end
    end
  end
  
  def sport_list(count=0)
    if count == 0
      sports.pluck(:sport).join(", ")
    else
      sports.pluck(:sport).first(count).join(", ")
    end
  end
  
  def teams
    teams = Team.where(id: team_ids)
  end 
  
  def school_ids
     school_ids = teams.pluck(:school_id).compact.uniq
  end
  
  def schools
    School.where(id: school_ids)
  end
  
  def classification_with_hyphen
    if classification.present?
      classification.downcase.gsub("recreational: ","").gsub(" ","-")
    end
  end
  
  def category_and_classification
    "#{classification_with_hyphen} #{category.try(:downcase)}"
  end
  



  

end

