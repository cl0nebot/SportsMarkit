class Relationship < ActiveRecord::Base
  #extend FriendlyId
  #friendly_id :use_for_slug, use: :slugged
  serialize :position, Array
  
  has_many :positionings, :as => :positionable, :dependent => :destroy
  has_many :positions, :through => :positionings
  
  belongs_to :user
  belongs_to :team
  
  def use_for_slug
    existing_relationship = Relationship.where('slug = ?', self.slug)
    if existing_relationship.present?
      "#{self.team.name} #{self.user.first_name.first} #{self.user.last_name} #{existing_relationship.count}"
    else
      "#{self.team.name} #{self.user.first_name.first} #{self.user.last_name}"
    end
  end
  
  def position_list
    positions.pluck(:position).join(", ")
  end
  
  
end
