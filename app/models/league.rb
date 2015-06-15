class League < ActiveRecord::Base
  extend FriendlyId
  include PhotoOwner
  friendly_id :use_for_slug, use: [:slugged, :finders]
  
  has_many :fans, as: :fannable
  has_many :team_leagues, dependent: :destroy
  has_many :medias, as: :mediable
  
  def use_for_slug
    existing_league = League.where('slug = ?', self.slug)
    if existing_league.present?
      "#{name} #{state} #{existing_league.count}"
    else
      "#{name} #{state}"
    end
  end
  
  def team_ids
    team_ids = TeamLeague.where(league_id: id).pluck(:team_id)
  end
  
  def teams
    teams = Team.where(id: team_ids)
  end
  
  def self.league_names
    League.pluck(:name)
  end
  
  def upcoming_events
    team_ids = TeamLeague.where(league_id: id).pluck(:team_id)
    Event.where(eventable_type: "Team", eventable_id: team_ids)
  end

  def all_events
    upcoming_events
  end
end
