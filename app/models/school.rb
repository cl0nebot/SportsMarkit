class School < ActiveRecord::Base
  extend FriendlyId
  include PhotoOwner

  friendly_id :use_for_slug, use: [:slugged, :finders]
  acts_as_gmappable
  
  has_many :fans, as: :fannable
  #has_many :event_facilities, as: :reservable
  has_many :teams
  has_many :facilities

  has_many :athletic_directors, dependent: :destroy
  has_many :users, through: :athletic_directors
  has_many :medias, as: :mediable
  
  attr_accessor :stripe_token

  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address_1}, #{self.city}, #{self.state}" 
  end


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
  
  def athletes
    team_ids = teams.pluck(:id)
    rels = Relationship.where(team_id: team_ids, accepted: true, participant: true)
    user_ids = rels.pluck(:user_id)
    users = User.where(id: user_ids)
  end
  
  def userless_athletes
    team_ids = teams.pluck(:id)
    relationships = UserlessRelationship.where(team_id: team_ids, participant: true)
    relationships.pluck(:first_name, :last_name)
  end
  
  def team_ids
     teams.pluck(:id)
  end
  
  def user_ids
    rels = Relationship.where(team_id: team_ids, accepted: true)
    rels.pluck(:user_id)
  end
  
  def people
    users = User.where(id: user_ids)
  end
  
  def userless_people
    rels = UserlessRelationship.where(team_id: team_ids)
  end
  
  def upcoming_events
    if premium?
      Event.where(eventable_type: "Team", eventable_id: team_ids).where('ends_at >= ?', Time.now)
    else
      Event.where(eventable_type: "Team", eventable_id: team_ids).where('starts_at <= ?', Date.today + 2.weeks).uniq
    end
  end

  def all_events
    upcoming_events
  end

  
  def next_event
    upcoming_events.first.nil? ? "No upcoming events" : upcoming_events.first.title
  end
  
  #coaches
  
  def coach_ids_for_school
    team_ids = teams.pluck(:id)
    relationships = Relationship.where(team_id: team_ids, head: true, accepted: true)
    coach_ids = relationships.pluck(:user_id)
  end
  
  def coaches_for_school
    coaches = User.where(id: coach_ids_for_school)
  end
  
  def userless_coaches_for_school
    team_ids = teams.pluck(:id)
    relationships = UserlessRelationship.where(team_id: team_ids, head: true)
    relationships.pluck(:first_name, :last_name)
  end
  
  # managers
  
  def manager_ids_for_school
    team_ids = teams.pluck(:id)
    relationships = Relationship.where(team_id: team_ids, manager: true, accepted: true)
    manager_ids = relationships.pluck(:user_id)
  end
  
  def userless_managers_for_school
    team_ids = teams.pluck(:id)
    relationships = UserlessRelationship.where(team_id: team_ids, manager: true)
    relationships.pluck(:first_name, :last_name)
  end
  
  # trainers
  
  def trainer_ids_for_school
    team_ids = teams.pluck(:id)
    relationships = Relationship.where(team_id: team_ids, trainer: true, accepted: true)
    trainer_ids = relationships.pluck(:user_id)
  end
  
  def userless_trainers_for_school
    team_ids = teams.pluck(:id)
    relationships = UserlessRelationship.where(team_id: team_ids, trainer: true)
    relationships.pluck(:first_name, :last_name)
  end
  
  # managers and trainers
  
  def manager_and_trainers
     users = User.where(id: manager_ids_for_school) + User.where(id: trainer_ids_for_school)
     manager_and_trainers = users.uniq
  end
  
  def userless_managers_and_trainers
    team_ids = teams.pluck(:id)
    manager_relationships = UserlessRelationship.where(team_id: team_ids, manager: true)
    trainer_relationships = UserlessRelationship.where(team_id: team_ids, trainer: true)
    (manager_relationships.pluck(:first_name, :last_name) + trainer_relationships.pluck(:first_name, :last_name)).uniq
  end
  
  
  
  def admin_ids_for_school
    team_ids = teams.pluck(:id)
    relationships = Relationship.where(team_id: team_ids, admin: true, accepted: true)
    ad_ids = athletic_directors.pluck(:user_id)
    admin_ids = relationships.pluck(:user_id)
    ad_ids + admin_ids
  end
  
  def admins
    admins = User.where(id: admin_ids_for_school)
  end
  
  def userless_admins
    team_ids = teams.pluck(:id)
    relationships = UserlessRelationship.where(team_id: team_ids, admin: true)
    relationships.pluck(:first_name, :last_name)
  end
  
  def school_certifications
    Certificate.where(user_id: coach_ids_for_school)
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
  
  def image
    if Photo.where(photo_owner_id: id, photo_owner_type: "School").present?
      Photo.where(photo_owner_id: id, photo_owner_type: "School").last.image
    else
      "http://www.carlostoxtli.com/wp-content/uploads/2014/05/placeholder15.png"
    end
  end
  
  def is_athletic_director?(user)
    AthleticDirector.where(school_id: id, user_id: user.id).present?
  end
    
end
