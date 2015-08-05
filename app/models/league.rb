class League < ActiveRecord::Base
  extend FriendlyId
  include PhotoOwner
  friendly_id :use_for_slug, use: [:slugged, :finders]
  
  has_many :fans, as: :fannable
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
  
  def self.league_names
    League.pluck(:name)
  end
  
  def schools
    school_ids = teams.pluck(:school_id).compact.uniq
    School.where(id: school_ids)
  end
  
  def athletes
    array = []
    teams.each do |team|
      array << team.accepted_athletes.pluck(:id)
    end
    array.uniq
    User.where(id: array)
  end
  
  def coaches
    array = []
    teams.each do |team|
      array << team.accepted_coaches.pluck(:id)
    end
    array.uniq
    User.where(id: array)
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
  
  
end

