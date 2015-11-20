class School < ActiveRecord::Base
  extend FriendlyId
  include PhotoOwner
  include EventDetail
  include Roster
  include Reusable
  include Geo
  include Avatar
  include ClassificationCount
  include Link
  
  has_many :roles, as: :roleable, dependent: :destroy
  has_many :userless_roles, as: :userless, dependent: :destroy

  friendly_id :use_for_slug, use: [:slugged, :finders]
  acts_as_gmappable
  
  has_many :fans, as: :fannable, dependent: :destroy
  has_many :facilities, as: :facility_owner
  has_many :events, as: :eventable
  #has_many :event_facilities, as: :reservable
  has_many :teams
  has_many :facilities
  
  has_many :facility_links, as: :facilitatable

  has_many :users, through: :athletic_directors
  has_many :medias, as: :mediable
  
  attr_accessor :stripe_token


  def use_for_slug
    existing_school = School.where('slug = ?', self.slug)
    if existing_school.present?
      "#{name} #{self.city_and_state} #{existing_school.count}"
    else
      "#{name} #{self.city_and_state}"
    end
  end
  
  def city_and_state
    "#{city}-#{state}"
  end
  
  def school_certifications
    Certificate.where(user_id: coaches.pluck(:id))
  end

  def self.school_names
    School.pluck(:name)
  end
  
  def self.claimable_schools
    where.not( id: AthleticDirector.select(:school_id).distinct)
  end

  def self.cached_claimable_schools(last_update)
    Rails.cache.fetch([self, last_update, "claimable_schools", "v1"]) { self.claimable_schools }
  end
  
  def proper_name
    name
  end
  
  def self.school_json
    array = []
    School.all.each do |school|
      array << {name: school.name, link: Rails.env.production? ? "http://www.sportsmarkit.com/schools/#{school.slug}" : "http://localhost:3000/schools/#{school.slug}"}
    end
    array
  end
  
  def image
    if Photo.where(photo_owner_id: id, photo_owner_type: "School").present?
      Photo.where(photo_owner_id: id, photo_owner_type: "School").last.image
    else
      "http://www.carlostoxtli.com/wp-content/uploads/2014/05/placeholder15.png"
    end
  end
  
  def is_athletic_director?(user)
    roles.where(status: "Active", role: "Athletic Director", user_id: user.id).present?
  end
  
  def general_information_present?
    [number_of_students.present? , motto.present? , colors.present?, number_of_teams.present?, mascot.present?].include? true
  end
  

  
  def classification_with_hyphen
    if classification.present?
      classification.downcase.gsub(" ","-")
    end
  end
  
  def category_and_classification
    "#{classification_with_hyphen} #{category.try(:downcase)}"
  end
  
  def league_names
    array = [] 
    teams.pluck(:id).each do |id|
      Team.find(id).leagues.each do |league|
        array << league.name  
      end
    end
    array.uniq.join(", ")
  end
  
  def all_leagues
    array = [] 
    teams.pluck(:id).each do |id|
      Team.find(id).leagues.each do |league|
        array << league.id  
      end
    end
     League.where(id: array.uniq)
  end
  
    
end
