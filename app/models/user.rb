class User < ActiveRecord::Base
  include Location
  include PhotoOwner

  extend FriendlyId
  friendly_id :use_for_slug, use: [:slugged, :finders]
  has_secure_password
  
  validates_presence_of :password, :on => :create
  validates :first_name, :presence => true, length: {minimum: 2, maximum: 20}
  validates :last_name, :presence => true, length: {minimum: 2, maximum: 20}
  #validates :email, :presence => true, :uniqueness => true

  before_save { self.email = email.downcase }

  before_create { generate_token(:authentication_token) }

  after_update :password_changed?, :on => :update
  before_save :encrypt_password
  
  # user profile
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile, :reject_if => :all_blank, :allow_destroy => true
  has_many :user_profile_pictures, dependent: :destroy
  accepts_nested_attributes_for :user_profile_pictures, :reject_if => :all_blank, :allow_destroy => true

  has_many :fans, as: :fannable
  has_many :events, as: :eventable
  
  has_many :relationships, dependent: :destroy
  has_many :teams, through: :relationships
  accepts_nested_attributes_for :relationships, :reject_if => :all_blank, :allow_destroy => true
  
  has_many :athletic_directors, dependent: :destroy
  has_many :schools, through: :athletic_directors
  
  has_many :attendees, dependent: :destroy
  has_many :classifications, dependent: :destroy
  has_many :measurables, dependent: :destroy
  has_many :certificates
  has_many :certifications, through: :certificates
  has_many :medias, as: :mediable

  def self.user_types
    ["Student Athlete", "Athlete", "Coach", "Parent", "Athletic Director", "Tournament Director" ]  
    #["Athlete", "Coach", "Parent", "Athletic Director", "Sports Blogger", "Sports Photographer", "Sports Writer", "Enthusiast", "Trainer", "Former Athlete"]  
    
  end
  
  def follows
    Fan.where(user_id: id)
  end
  
  def attendances
    Attendee.where(user_id: id)
  end
  
  def attending_events
    attendances.pluck(:event_id)
  end
  
  def all_events
    Event.where("(eventable_id = ? AND eventable_type = 'User') OR (id in (?))", id, attending_events)
  end
  
  def upcoming_events
    all_events.where('starts_at >= ?', Time.now)
  end
  
  def next_event
    all_events.first.nil? ? "No upcoming events" : all_events.first.title
  end

  def event_type_filters
    type_to_count = Hash.new(0)
    all_events.each do |event|
      if ##
        type_to_count[event.event_type] += 1
      end
    end
    type_filters = type_to_count.map do |type, count|
      current = current_filters.any? { |f| f[:type]=="event_type" and f[:value]== type}
      {type: "event_type", value: type, count: count, current: current}
    end
    type_filters.sort{|a,b| b[:count] <=> a[:count]}
  end
  
  def created_by_filters
    person_to_count = Hash.new(0)
    all_events.each do |event|
      if ##
        if event.user_id == id
          person_name = "Me"
        else
          person_name = User.find(event.user_id).full_name
        end
        person_to_count[person_name] += 1
      end
    end
    person_filters = person_to_count.map do |person, count|
      current = current_filters.any? { |f| f[:type] == "created_by" and f[:valye] == person}
      {type: "created_by", value: type, count: count, current: current}
    end
    person_filters.sort{|a,b| b[:count] <=> a[:count]}
  end
  
  attr_accessor :stripe_token, :current_password

  def password_changed?
    #if (provider.nil? || provider.try(:empty?))
      if password_digest_changed?
        # self.update_attributes(old_password: "example")
         #Emails.password_changed(self).deliver
      end
      #end
  end

  def full_name
    [first_name, middle_name,last_name].join(" ")
  end

  def use_for_slug
    existing_user = User.where('first_name = ?', self.first_name).where('last_name = ?', self.last_name)
    if existing_user.present?
      "#{first_name} #{last_name} #{existing_user.count}"
    else
      "#{first_name} #{last_name}"
    end
  end

  def avatar
    if user_profile_pictures.last.try(:id).blank?
      "http://hasslefreeliving.com/wp-content/uploads/2012/10/placeholder.gif"
    else
      user_profile_pictures.last.photo
    end
  end

  def encrypt_password
    unless self.password.nil?
      self.password_digest = BCrypt::Password.create(self.password)
    end
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def name
    full_name
  end

  def name=(val)
    self.first_name, self.middle_name, self.last_name = val.split
  end
  
  def formatted_mobile_phone_number
    "#{self.profile.mobile_phone_number}"
  end
  
  def index_position
    array = []
    users = User.all
    users.each do |u|
      array << u.id
    end
    array.uniq.find_index(id) + 1
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:reset_password_token)
    self.reset_password_sent_at = Time.zone.now
    save!
    SendEmail.password_reset(self).deliver
  end
  
  def self.from_omniauth(auth)
    #return nil if auth.nil?
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = "#{auth.info.nickname}@facebook.com"
      user.password = SecureRandom.urlsafe_base64
      # user.nearest_city = "New York, NY" # Default
      #user.oauth_token = auth.credentials.token
      #user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      if user.save
        #UserProfilePicture.create!(user_id: user.id, remote_photo_url: auth.info.image )
      end
    end
  end
  
  def is_parent?
    Classification.where(user_id: id, classification: "Parent").present?
  end
  
  def is_athlete?
    if Classification.where(user_id: id, classification: "Athlete").present?
      true
    elsif Relationship.where(user_id: id, participant: true).present?
      true
    else
      false
    end
  end
  
  def is_coach?
    if Classification.where(user_id: id, classification: "Coach").present?
      true
    elsif Relationship.where(user_id: id, head: true).present?
      true
    else
      false
    end 
  end
  
  def is_athletic_director?
    if Classification.where(user_id: id, classification: "Athletic Director").present?
      true
    elsif AthleticDirector.where(user_id: id).present?
      true
    else
      false
    end
  end
  
  def children_events #TODO finish
    # if ParentChild.where(parent_id: id).present?
    #   kid_id = ParentChild.where(parent_id: id).last
    #   kid = User.friendly.find(kid_id)
    #   kid.attendances
    # end
  end
  
  def shared_teams(user_id)
    user = User.find(user_id)
    user_team_ids = teams.pluck(:id)
    teammate_team_ids = user.teams.pluck(:id)
    user_team_ids & teammate_team_ids
  end
  
  def can_edit_team?(team)
    if Relationship.where(user_id: id, head: true, team_id: team.id).present?
      true
    elsif AthleticDirector.where(user_id: id, school_id: team.school_id).present?
      true
    elsif admin?
      true
    else
      false
    end
  end
  
  def self.athletes
    relationship_user_ids = Relationship.where(participant: true).pluck(:user_id)
    student_athlete_user_ids = Classification.where(classification: "Student Athlete").pluck(:user_id) 
    athlete_user_ids = Classification.where(classification: "Athlete").pluck(:user_id) 
    unique_user_ids = (relationship_user_ids + student_athlete_user_ids + athlete_user_ids).uniq
    all_athletes = User.where(id: unique_user_ids)
  end
  
  def self.user_names
    array = []
    User.all.each do |user|
      array << "#{user.full_name}"
    end
    array
  end
  
  def self.athlete_names
    array = []
    User.athletes.each do |user|
      array << "#{user.full_name}"
    end
    array
  end
  
  def pending_team?(team)
    if Relationship.where(team_id: team.id, user_id: id, accepted: nil).present?
      true
    else
      false
    end
  end
  
  def coached_teams
    coached_team_ids = Relationship.where(user_id: id, head: true).pluck(:team_id)
    coached_teams = Team.where(id: coached_team_ids)
  end
  
  def children
    children_ids = ParentChild.where(parent_id: id).pluck(:child_id)
    children = User.where(id: children_ids)
  end
  
  def age
    if profile.date_of_birth.present?
      days = (Date.today - profile.date_of_birth).to_i
      age = days / 365
    else
      "N/A"
    end
  end
  
  def classification_list(count=0)
    if count == 0
     classifications.pluck(:classification).join(", ")
   else
     classifications.pluck(:classification).first(count).join(", ")
   end
  end
  
  def has_profile_picture?
    user_profile_pictures.present?
  end
  
  def user_schools
    team_ids = relationships.pluck(:team_id)
    teams = Team.where(id: team_ids).where.not(school_id: nil)
    school_ids = teams.pluck(:school_id) + AthleticDirector.where(user_id: id).pluck(:school_id)
    schools = School.where(id: school_ids).uniq
  end
  
  def user_teams
    team_ids = relationships.where(accepted: true).pluck(:team_id)
    teams = Team.where(id: team_ids)
  end
  
  def event_notifications
    team_ids = Relationship.where(user_id: id).pluck(:team_id)
    all_team_events_after_today = Event.where(eventable_type: "Team", eventable_id: team_ids).where('starts_at >= ?', Time.now)
    
    array = []
    all_team_events_after_today.each do |event|
      unless event.attendees.where(user_id: id).present?
        array << event.id
      end
    end
    Event.where(id: array)
  end
  
  def schools_and_teams
    user_schools + user_teams
  end
  
  def lead_affiliation
    if user_schools.empty?
      user_teams.first
    else
      user_schools.first
    end
  end
  
  def image
    avatar
  end
  
  def name
    full_name
  end

  
  
    
  

end
