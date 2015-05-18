class League < ActiveRecord::Base
  extend FriendlyId
  friendly_id :use_for_slug, use: :slugged
  
  has_many :fans, as: :fannable
  has_many :team_leagues
  
  def use_for_slug
    existing_league = League.where('slug = ?', self.slug)
    if existing_league.present?
      "#{name} #{state} #{existing_league.count}"
    else
      "#{name} #{state}"
    end
  end
end
