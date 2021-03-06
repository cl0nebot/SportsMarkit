class School < ActiveRecord::Base
  extend FriendlyId
  include Images
  include EventDetail
  include Roster
  include Shared
  include Map
  include ClassificationCount
  include Common
  include Access
  include Import
  include Seed

  has_many :forms, as: :formable, dependent: :destroy

  friendly_id :use_for_slug, use: [:slugged, :finders]

  has_many :events, as: :eventable
  #has_many :event_facilities, as: :reservable

  has_many :roles, as: :roleable, dependent: :destroy
  has_many :userless_roles, as: :userless, dependent: :destroy

  validates :name, presence: true

  before_update :update_slug

  has_many :documents, as: :documentable, dependent: :destroy

  attr_accessor :stripe_token

  def minus_self
    School.where.not(id: id)
  end

  def use_for_slug
    existing_school = School.where('slug = ?', self.slug)
    if existing_school.present?
      "#{name} #{self.address.city_and_state} #{existing_school.count}"
    else
      "#{name} #{self.address.city_and_state}"
    end
  end

  def update_slug
    if (name_changed? || address.city_changed? || address.state_changed?)
      existing_school = self.minus_self.where('slug = ?', self.slug)
      if existing_school.present?
        update_column(:slug, "#{ApplicationController.helpers.to_slug(name, address.city_and_state, existing_school.count)}")
      else
        update_column(:slug, "#{ApplicationController.helpers.to_slug(name, address.city_and_state)}")
      end
    end
  end

  def self.claimable_schools
    where.not( id: Role.where(roleable_type: "School", status: "Active", role: ["Athletic Director", "School Manager"]).pluck(:roleable_id))
  end

  def self.cached_claimable_schools(last_update)
    Rails.cache.fetch([self, last_update, "claimable_schools", "v1"]) { self.claimable_schools }
  end


  def classification_with_hyphen
    if classification.present?
      classification.downcase.gsub(" ","-")
    end
  end

  def category_and_classification
    "#{classification_with_hyphen} #{category.try(:downcase)}"
  end

  def self.search(term)
    if term.length >= 1
      where("LOWER(name) LIKE ? OR LOWER(name) LIKE ?", "#{term.downcase}%", "% #{term.downcase}%")
    else
      all
    end
  end
end
