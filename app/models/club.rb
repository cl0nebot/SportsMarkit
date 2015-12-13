class Club < ActiveRecord::Base
  extend FriendlyId
  include Images
  include Common
  include EventDetail
  include Access
  include Shared
  include Map
  
  serialize   :sports, Array
  has_many :roles, as: :roleable, dependent: :destroy
  has_many :userless_roles, as: :userless, dependent: :destroy
  has_many :facilities, as: :facility_owner
  has_many :events, as: :eventable
  friendly_id :use_for_slug, use: [:slugged, :finders]
  acts_as_gmappable
  
  before_update :update_slug
  
  def minus_self
    Club.where.not(id: id)
  end

  def use_for_slug
    existing_club = Club.where('slug = ?', self.slug)
    if existing_club.present?
      "#{name} #{self.address.city_and_state} #{existing_club.count}"
    else
      "#{name} #{self.address.city_and_state}"
    end
  end
  
  def update_slug
    if (name_changed? || address.city_changed? || address.state_changed?)
      existing_club = self.minus_self.where('slug = ?', self.slug)
      if existing_club.present?
        update_column(:slug, "#{ApplicationController.helpers.to_slug(name, address.city_and_state, existing_club.count)}")
      else
        update_column(:slug, "#{ApplicationController.helpers.to_slug(name, address.city_and_state)}")
      end
    end
  end
  
  
  def club_certifications
    Certificate.where(user_id: [])#coaches.pluck(:id))
  end
    

end