class Team < ActiveRecord::Base
  extend FriendlyId
  include PhotoOwner

  friendly_id :use_for_slug, use: [:slugged, :finders]
  
  has_many :fans, as: :fannable
  belongs_to :school
  has_many :events, as: :eventable
  has_many :team_facilities
  has_many :team_leagues
  
  has_many :relationships
  has_many :users, through: :relationships
  
  
  def use_for_slug
    existing_team = Team.where('slug = ?', self.slug)
    if existing_team.present?
      "#{name} #{self.school.name if self.school} #{sport} #{existing_team.count}"
    else
      "#{name} #{self.school.name if self.school} #{sport}"
    end
  end

  def all_events
    events
  end

  def upcoming_events
    Event.where(eventable_type: "Team", eventable_id: id)
  end
  
  def next_event
    upcoming_events.first.nil? ? "No upcoming events" : upcoming_events.first.title
  end
  
  def facilities
    team_facilities = TeamFacility.where(team_id: id)
    facility_ids = team_facilities.pluck(:facility_id)
    Facility.where(id: facility_ids)
  end
  
  def leagues
    team_leagues = TeamLeague.where(team_id: id)
    league_ids = team_leagues.pluck(:league_id)
    League.where(id: league_ids)
  end

  def pending_members
    relationships.where(accepted: nil, rejected: nil)
  end
  
  def accepted_athletes
    user_ids = Relationship.where(team_id: id, participant: true, accepted: true).pluck(:user_id)
    User.where(id: user_ids )
  end
  
  def accepted_coaches
    user_ids = Relationship.where(team_id: id, head: true, accepted: true).pluck(:user_id)
    User.where(id: user_ids )
  end
  
  def accepted_athlete_relationships
    Relationship.where(team_id: id, participant: true, accepted: true)
  end
  
  def accepted_coach_relationships
    Relationship.where(team_id: id, head: true, accepted: true)
  end
  
  def self.with_schools
    Team.where.not(school_id: nil)
  end
  
  def self.school_team_names
    array = []
    Team.with_schools.each do |team|
      array << "#{team.school.name} #{team.name}"
    end
    array
  end

  def self.without_schools
    Team.where(school_id: nil)
  end

  def self.non_school_team_names
    array = []
    Team.without_schools.each do |team|
      array << "#{team.name}"
    end
    array
  end

  def self.team_names
    self.school_team_names + self.non_school_team_names
  end
  
  
  def city_state
    if school_id.present?
      "#{school.city}, #{school.state}"  
    else
      "#{city}, #{state}"
    end
  end
  
  def with_school_name
    "#{school.name} #{name}"
  end
  
  def proper_name
    if school_id.present?
      with_school_name
    else
      name
    end
  end

end
