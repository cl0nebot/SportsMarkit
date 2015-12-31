class Facility < ActiveRecord::Base
  extend FriendlyId
  include Images
  include EventDetail
  include Common
  include Map
  include Shared
  include Access
  include Import

  friendly_id :use_for_slug, use: [:slugged, :finders]
  
  belongs_to :facility_owner, polymorphic: true
  belongs_to :school
  
  has_many :roles, as: :roleable, dependent: :destroy
  has_many :userless_roles, as: :userless, dependent: :destroy
  
  has_many :connects, as: :connectable, dependent: :destroy
  
  has_many :events, as: :eventable
  has_many :team_facilities
  before_update :update_slug
  
  def minus_self
    Facility.where.not(id: id)
  end
  
  def use_for_slug
    existing_facility = Facility.where('slug = ?', self.slug)
    owner_name = self.facility_owner_type.present? ? self.facility_owner_type.constantize.find(self.facility_owner_id).name : nil
    
    if existing_facility.present?
      "#{owner_name} #{name} #{self.address.city_and_state} #{existing_facility.count}"
    else
      "#{owner_name} #{name} #{self.address.city_and_state}"
    end
  end
  
  def update_slug
    owner_name = self.facility_owner_type.present? ? self.facility_owner_type.constantize.find(self.facility_owner_id).name : nil
    if (name_changed? || address.city_changed? || address.state_changed?)
      existing_facility = self.minus_self.where('slug = ?', self.slug)
      if existing_facility.present?
        update_column(:slug, "#{ApplicationController.helpers.to_slug(owner_name, name, address.city_and_state, existing_facility.count)}")
      else
        update_column(:slug, "#{ApplicationController.helpers.to_slug(owner_name, name, address.city_and_state)}")
      end
    end
  end
  
  
  def self.type_with_hyphen(type)
    type.downcase.gsub(" ","-")
  end
  
  def type_with_hyphen
    if facility_type.present?
      facility_type.downcase.gsub(" ","-")
    end
  end
  
end
