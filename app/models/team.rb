class Team < ActiveRecord::Base
  extend FriendlyId
  friendly_id :use_for_slug, use: :slugged
  
  has_many :fans, as: :fannable
  belongs_to :school
  has_many :events, as: :eventable
  has_many :facilities
  
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
end
