class Team < ActiveRecord::Base
  extend FriendlyId
  include PhotoOwner
  include Reusable
  include Roster
  include EventDetail
  include Avatar

  friendly_id :use_for_slug, use: [:slugged, :finders]
  
  has_many :fans, as: :fannable
  belongs_to :school
  has_many :events, as: :eventable
  has_many :team_leagues
  has_many :medias, as: :mediable
  has_many :facility_links, as: :facilitatable
  
  has_many :relationships
  has_many :userless_relationships
  has_many :users, through: :relationships
  
  has_many :chatrooms
  
  validates :sport, presence: true
  
  
  
  
  def use_for_slug
    existing_team = Team.where('slug = ?', self.slug)
    if existing_team.present?
      "#{name} #{self.school.name if self.school} #{sport} #{existing_team.count}"
    else
      "#{name} #{self.school.name if self.school} #{sport}"
    end
  end
  
  def is_premium?
    if school_id.present?
      if school.premium?
        true
      else
        false
      end
    else
      if premium?
        true
      else
        false
      end
    end
  end

  def all_events
    if is_premium?
      events
    else
      events.where('starts_at <= ?', Date.today + 2.weeks).uniq
    end
  end

  def upcoming_events
    if is_premium?
      Event.where(eventable_type: "Team", eventable_id: id).where('ends_at >= ?', Time.now)
    else
      Event.where(eventable_type: "Team", eventable_id: id).where('starts_at <= ?', Date.today + 2.weeks).uniq
    end
  end
  

  
  def facilities
    team_facilities = TeamFacility.where(team_id: id)
    facility_ids = team_facilities.pluck(:facility_id)
    Facility.where(id: facility_ids)
  end
  
  def leagues
    team_leagues = TeamLeague.where(team_id: id)
    league_ids = team_leagues.pluck(:league_id)
    League.where(id: league_ids)
  end

  def pending_members
    relationships.where(accepted: nil, rejected: nil)
  end
  
  
  def accepted_athlete_relationships
    rels = Relationship.where(team_id: id, participant: true, accepted: true)
    userless_rels = UserlessRelationship.where(team_id: id, participant: true)
    rels + userless_rels
  end
  
  def accepted_coach_relationships
    rels = Relationship.where(team_id: id, head: true, accepted: true)
    userless_rels = UserlessRelationship.where(team_id: id, head: true)
    rels + userless_rels
  end
  
  def accepted_trainer_relationships
    rels = Relationship.where(team_id: id, trainer: true, accepted: true)
    userless_rels = UserlessRelationship.where(team_id: id, trainer: true)
    rels + userless_rels
  end
  
  def accepted_manager_relationships
    rels = Relationship.where(team_id: id, manager: true, accepted: true)
    userless_rels = UserlessRelationship.where(team_id: id, manager: true)
    rels + userless_rels
  end
  
  def self.with_schools
    Team.where.not(school_id: nil)
  end
  
  def self.school_team_names
    array = []
    Team.with_schools.each do |team|
      array << "#{team.school.name} #{team.name}"
    end
    array
  end

  def self.without_schools
    Team.where(school_id: nil)
  end

  def self.non_school_team_names
    array = []
    Team.without_schools.each do |team|
      array << "#{team.name}"
    end
    array
  end

  def self.team_names
    self.school_team_names + self.non_school_team_names
  end
  
  
  def city_state
    if school_id.present?
      comma = (school.city.present? && school.state.present?) ? "," : ""
      "#{school.city}#{comma} #{school.state}"  
    else
      comma = (city.present? && state.present?) ? "," : ""
      "#{city}#{comma} #{state}"
    end
  end
  
  def with_school_name
    "#{school.name} #{name}"
  end
  
  def proper_name
    if school_id.present?
      with_school_name
    else
      name
    end
  end
  
  def image
    if Photo.where(photo_owner_id: id, photo_owner_type: "Team").present?
      Photo.where(photo_owner_id: id, photo_owner_type: "Team").last.image
    else
      "http://cache3.asset-cache.net/gc/187840132-soccer-team-celebrates-gettyimages.jpg?v=1&c=IWSAsset&k=2&d=ZQZzMJ8a0ONoFbdvawrO3ZhmEQ83NvPgJ9Rxm5hkoQw%3d"
    end
  end
  
  def is_athletic_director?(user)
    if school.present?
      school.is_athletic_director?(user)
    else
      false
    end
  end
  
  def last_chat_stream_message_id
    Message.where(chatroom_id: id).last.find_beginning_of_stream
  end
  
  def people
    relationships.where(accepted: true).uniq
  end
  

  
  def classification_and_category
    if school_id.present?
      school_class = school.category_and_classification
    end
    
    if classification.present?
      self_class = classification.downcase.gsub("recreational: ","").gsub(" ","-")
    end
    
    if school_class.nil? 
      self_class
    elsif self_class.nil?
      school_class
    else
      school_class + self_class
    end
  end
  
  def self.type_with_hyphen(type)
    type.downcase.gsub("recreational: ","").gsub(" ","-")
  end
  
  def self.classifications
    school_ids = Team.all.pluck(:school_id).compact.uniq
    classifications = School.where(id: school_ids).pluck(:classification).compact.uniq
    categories = School.where(id: school_ids).pluck(:category).compact.uniq
    more = Team.all.pluck(:classification).compact.uniq
    classifications + categories + more
  end
  
  def self.count_for_classification(classification)
    if Team.all.pluck(:classification).include? classification
      Team.where(classification: classification).count
    elsif School.pluck(:classification).include? classification
      Team.joins(:school).merge(School.where(:classification => classification)).count
    else
      Team.joins(:school).merge(School.where(:category => classification)).count
    end
  end

end
