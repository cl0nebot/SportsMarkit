class User < ActiveRecord::Base
  include Location
  extend FriendlyId
  friendly_id :use_for_slug, use: [:slugged, :finders]
  has_secure_password
  
  validates_presence_of :password, :on => :create
  validates :first_name, :presence => true, length: {minimum: 2, maximum: 20}
  validates :last_name, :presence => true, length: {minimum: 2, maximum: 20}
  validates :email, :presence => true, :uniqueness => true

  before_save { self.email = email.downcase }

  before_create { generate_token(:authentication_token) }

  after_update :password_changed?, :on => :update
  before_save :encrypt_password
  
  # user profile
  has_one :profile
  accepts_nested_attributes_for :profile, :reject_if => :all_blank, :allow_destroy => true
  has_many :user_profile_pictures #TODO dependent destroy?
  accepts_nested_attributes_for :user_profile_pictures, :reject_if => :all_blank, :allow_destroy => true
  
  has_many :user_profile_pictures #TODO dependent destroy?
  
  has_many :fans, as: :fannable
  has_many :events, as: :eventable
  
  has_many :relationships
  has_many :teams, through: :relationships
  
  has_many :attendees
  
  USER_TYPES = ["Athlete", "Parent", "Coach", "Sports Blogger", "Sports Photographer", "Sports Writer", "Enthusiast", "Trainer", "Former Athlete"]
  
  
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
    Event.where("(`eventable_id` = ? AND `events`.`eventable_type` = 'User') OR (id in (?))", id, attending_events)
  end
  
  def upcoming_events
    all_events
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
      "http://www.clker.com/cliparts/A/Y/O/m/o/N/placeholder-md.png"
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
  
  
  
    
  

end
