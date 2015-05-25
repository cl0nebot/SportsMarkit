class Team < ActiveRecord::Base
  extend FriendlyId
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
  
  
end
