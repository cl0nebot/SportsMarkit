class League < ActiveRecord::Base
  extend FriendlyId
  friendly_id :use_for_slug, use: :slugged
  
  has_many :fans, as: :fannable
  has_many :team_leagues
  has_many :medias, as: :mediable
  
  def use_for_slug
    existing_league = League.where('slug = ?', self.slug)
    if existing_league.present?
      "#{name} #{state} #{existing_league.count}"
    else
      "#{name} #{state}"
    end
  end
  
  def teams
    team_ids = TeamLeague.where(league_id: id).pluck(:team_id)
    teams = Team.where(id: team_ids)
  end
  
  def self.league_names
    League.pluck(:name)
  end
end
