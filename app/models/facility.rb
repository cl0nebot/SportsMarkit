class Facility < ActiveRecord::Base
  extend FriendlyId
  include PhotoOwner

  friendly_id :use_for_slug, use: [:slugged, :finders]
  acts_as_gmappable
  
  belongs_to :team
  belongs_to :school
  
  has_many :fans, as: :fannable
  has_many :event_facilities
  has_many :events, through: :event_facilities
  has_many :team_facilities
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    if self.school.present?
      "#{self.school.address_1}, #{self.school.city}, #{self.school.state}"
    else
      "#{self.address_1}, #{self.city}, #{self.state}" 
    end
  end
  
  def use_for_slug
    existing_facility = Facility.where('slug = ?', self.slug)
    school_present = self.school.present?
    
    if existing_facility.present?
      if school_present
        "#{self.school.name} #{name} #{self.city_and_state} #{existing_facility.count}"
      else
        "#{name} #{self.city_and_state} #{existing_facility.count}"
      end
    else
      if school_present
        "#{self.school.name} #{name} #{self.city_and_state}"
      else
        "#{name} #{self.city_and_state}"
      end
    end
    
  end
  
  def city_and_state
    "#{city}-#{state}"
  end
  
  def full_address
    
  end
  
  def all_teams
    team_ids = TeamFacility.where(facility_id: id).pluck(:team_id)
    teams = Team.where(id: team_ids)
  end

  def all_events
    events
  end
  
  def people_that_use_facility
    team_ids = all_teams.pluck(:id)
    relationships = Relationship.where(team_id: team_ids)
    user_ids = relationships.pluck(:user_id)
    users = User.where(id: user_ids)
  end
  
  def self.facility_names
    Facility.pluck(:name)
  end
  
end
