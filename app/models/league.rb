class League < ActiveRecord::Base
  extend FriendlyId
  include PhotoOwner
  friendly_id :use_for_slug, use: [:slugged, :finders]
  
  has_many :fans, as: :fannable
  has_many :facilities, as: :facility_owner
  has_many :team_leagues, dependent: :destroy
  has_many :medias, as: :mediable
  
  has_many :league_sports, :dependent => :destroy
  has_many :sports, :through => :league_sports
  
  def use_for_slug
    existing_league = League.where('slug = ?', self.slug)
    if existing_league.present?
      "#{name} #{state} #{existing_league.count}"
    else
      "#{name} #{state}"
    end
  end
  
  def sport_list(count=0)
    if count == 0
      sports.pluck(:sport).join(", ")
    else
      sports.pluck(:sport).first(count).join(", ")
    end
  end
  
  def team_ids
    team_ids = TeamLeague.where(league_id: id).pluck(:team_id)
  end
  
  def teams
    teams = Team.where(id: team_ids)
  end
  
  def userless_athletes
    team_ids = teams.pluck(:id)
    relationships = UserlessRelationship.where(team_id: team_ids, participant: true)
    relationships.pluck(:first_name, :last_name)
  end
  
  def userless_people
    rels = UserlessRelationship.where(team_id: team_ids)
  end
  
  def user_ids
    rels = Relationship.where(team_id: team_ids, accepted: true)
    rels.pluck(:user_id)
  end
  
  def people
    users = User.where(id: user_ids)
  end
  
  def self.league_names
    League.pluck(:name)
  end
  
  def school_ids
     school_ids = teams.pluck(:school_id).compact.uniq
  end
  
  def schools
    School.where(id: school_ids)
  end
  
  def athletes
    array = []
    teams.each do |team|
      array << team.accepted_athletes.pluck(:id)
    end
    User.where(id: array.flatten.uniq)
  end
  
  def coaches
    array = []
    teams.each do |team|
      array << team.accepted_coaches.pluck(:id)
    end
    User.where(id: array.flatten.uniq)
  end
  
  def upcoming_events
    team_ids = TeamLeague.where(league_id: id).pluck(:team_id)
    Event.where(eventable_type: "Team", eventable_id: team_ids).where('ends_at >= ?', Time.now)
  end
  
  def next_event
    upcoming_events.first.nil? ? "No upcoming events" : upcoming_events.first.title
  end

  def all_events
    upcoming_events
  end
  
  def image
    if Photo.where(photo_owner_id: id, photo_owner_type: "League").present?
      Photo.where(photo_owner_id: id, photo_owner_type: "League").last.image
    else
      "http://www.hsph.harvard.edu/niehs/wp-content/themes/hsph/images/placeholder.jpg"
    end
  end
  
  def city_and_state
    if city.present? && state.present?
      "#{city}, #{state}"
    elsif state.present? && !city.present?
      "#{state}"
    else
      ""
    end
  end
  
  def zip_and_ext
    if !zip.present?
      ""
    elsif zip.present? && zip_ext.present?
      "#{zip}-#{zip_ext}"
    elsif !zip_ext.present?
      "#{zip}"
    end
  end
  
  def address
   address = "#{address_1}#{", " if address_2.present? }#{address_2 if address_2.present?}#{"," if (city_and_state.present? && address_1.present?) } #{city_and_state if city_and_state.present?} #{zip_and_ext}"
   address.strip
  end
  
  def social_media_present?
    [facebook.present? , linkedin.present? ,  youtube.present?, twitter.present?, instagram.present?, pinterest.present?].include? true
  end
  
  def athletic_directors
    array =[]
    school_ids = teams.pluck(:school_id).compact.uniq
    School.where(id: school_ids).each do |school|
      array << school.athletic_directors.pluck(:user_id)
    end
    User.where(id: array.flatten.uniq)
  end
  
  #coaches
  
  def coach_ids_for_league
    team_ids = teams.pluck(:id)
    relationships = Relationship.where(team_id: team_ids, head: true, accepted: true)
    coach_ids = relationships.pluck(:user_id)
  end
  
  def coaches_for_league
    coaches = User.where(id: coach_ids_for_league)
  end
  
  def userless_coaches_for_league
    team_ids = teams.pluck(:id)
    relationships = UserlessRelationship.where(team_id: team_ids, head: true)
    relationships.pluck(:first_name, :last_name)
  end
  
  # managers
  
  def manager_ids_for_league
    team_ids = teams.pluck(:id)
    relationships = Relationship.where(team_id: team_ids, manager: true, accepted: true)
    manager_ids = relationships.pluck(:user_id)
  end
  
  def userless_managers_for_league
    team_ids = teams.pluck(:id)
    relationships = UserlessRelationship.where(team_id: team_ids, manager: true)
    relationships.pluck(:first_name, :last_name)
  end
  
  # trainers
  
  def trainer_ids_for_league
    team_ids = teams.pluck(:id)
    relationships = Relationship.where(team_id: team_ids, trainer: true, accepted: true)
    trainer_ids = relationships.pluck(:user_id)
  end
  
  def userless_trainers_for_league
    team_ids = teams.pluck(:id)
    relationships = UserlessRelationship.where(team_id: team_ids, trainer: true)
    relationships.pluck(:first_name, :last_name)
  end
  
  # managers and trainers
  
  def manager_and_trainers
     users = User.where(id: manager_ids_for_league) + User.where(id: trainer_ids_for_league)
     manager_and_trainers = users.uniq
  end
  
  def userless_managers_and_trainers
    team_ids = teams.pluck(:id)
    manager_relationships = UserlessRelationship.where(team_id: team_ids, manager: true)
    trainer_relationships = UserlessRelationship.where(team_id: team_ids, trainer: true)
    (manager_relationships.pluck(:first_name, :last_name) + trainer_relationships.pluck(:first_name, :last_name)).uniq
  end
  
  def athletic_director_ids_for_league
    array = []
    School.where(id: school_ids).each do |school|
      array << school.athletic_directors.pluck(:user_id)
    end
    array.flatten.uniq
  end
  
  
  
  def admin_ids_for_league 
    team_ids = teams.pluck(:id)
    relationships = Relationship.where(team_id: team_ids, admin: true, accepted: true)
    admin_ids = relationships.pluck(:user_id)
    athletic_director_ids_for_league + admin_ids
  end
  
  def admins
    admins = User.where(id: admin_ids_for_league)
  end
  
  def userless_admins
    team_ids = teams.pluck(:id)
    relationships = UserlessRelationship.where(team_id: team_ids, admin: true)
    relationships.pluck(:first_name, :last_name)
  end
  
  def number_of_people_online
    array = []
    people.each do |p|
       if p.online_status.present?
         array << 1
       end
    end
    array.length
  end
  
  def last_activity
    array = []
    people.each do |p|
       if p.online_status.present?
         array << p.online_status.last_seen
       end
    end
    array.max
  end
  



  

end

