class User < ActiveRecord::Base
  include Location
  include Images
  include Access
  include Shared
  include ClassificationCount
  include EventDetail
  include Common
  include StripeRegistration

  extend FriendlyId
  friendly_id :use_for_slug, use: [:slugged, :finders]
  before_update :update_slug
  has_secure_password validations: false

  validates_presence_of :password, :on => :create, if: -> { is_parent? }
  validates :first_name, :presence => true, length: {minimum: 2, maximum: 20}
  validates :last_name, :presence => true, length: {minimum: 2, maximum: 20}
  validates :email, :uniqueness => true, allow_blank: true, if: -> { is_parent? }
  validates :username, :uniqueness => true, allow_blank: true
  validates :mobile_phone_number, :uniqueness => true, allow_blank: true, if: -> { is_parent? }

  before_create { generate_token(:authentication_token) }
  before_save :fix_email
  before_save :fix_phone

  after_update :password_changed?, :on => :update
  before_save :encrypt_password

  has_many :roles, dependent: :destroy

  # user profile
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile, :reject_if => :all_blank, :allow_destroy => true
  has_many :user_profile_pictures, dependent: :destroy
  accepts_nested_attributes_for :user_profile_pictures, :reject_if => :all_blank, :allow_destroy => true

  belongs_to :parent, class_name: "User"

  has_many :events, as: :eventable

  has_many :attendees, dependent: :destroy
  has_many :attending_events, through: :attendees, source: :events
  has_many :classifications, dependent: :destroy
  has_many :measurables, dependent: :destroy
  has_many :certificates, dependent: :destroy
  has_many :certifications, through: :certificates
  has_many :medias, as: :mediable
  has_many :verifications
  has_many :verified_measurables, through: :verifications, :source_type => 'Measurable', source: :verifiable
  has_many :announcements
  has_many :children, class_name: "User", foreign_key: :parent_id

  has_one :online_status
  has_many :signed_documents, dependent: :destroy

  def is_child?
    parent_id.present?
  end

  def email
    if is_child?
      parent.email
    else
      super
    end
  end

  def mobile_phone_number
    if is_child?
      parent.mobile_phone_number
    else
      super
    end
  end

  def self.user_types
    ["Student Athlete", "Athlete", "Coach", "Guardian", "Athletic Director", "Club Director", "School Manager", "Team Manager"]
  end

  def self.smart_order(user)
    id = user.try(:id) || 0
    User.order("id = #{id} desc")
  end

  def minus_self
    User.where.not(id: id)
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

  def self.athletes
    user_ids = Classification.where(classification: "Athlete").pluck(:user_id)
    users = User.where(id: user_ids)
  end

  def all_events
    Event.where("(eventable_id = ? AND eventable_type = 'User') OR (id in (?))", id, attending_events)
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
    if password_digest_changed?
    end
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

  def update_slug
    if (first_name_changed? || last_name_changed?)
      existing_user = minus_self.where('first_name = ?', self.first_name).where('last_name = ?', self.last_name)
      if existing_user.present?
        update_column(:slug, "#{ApplicationController.helpers.to_slug(first_name, last_name, (existing_user.count))}")
      else
        update_column(:slug, "#{ApplicationController.helpers.to_slug(first_name, last_name)}")
      end
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
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = "#{auth.info.nickname}@facebook.com"
      user.password = SecureRandom.urlsafe_base64
      if user.save
      end
    end
  end

  def is_parent?
    if Classification.where(user_id: id, classification: "Parent").present?
      true
    elsif Role.where(user_id: id, roleable_type: "Team", status: "Active", role: "Guardian").present?
      true
    else
      false
    end
  end

  def is_athlete?
    if Classification.where(user_id: id, classification: "Athlete").present?
      true
    elsif Role.where(user_id: id, roleable_type: "Team", status: "Active", role: "Athlete").present?
      true
    else
      false
    end
  end

  def is_coach?
    if Classification.where(user_id: id, classification: "Coach").present?
      true
    elsif Role.where(user_id: id, roleable_type: "Team", status: "Active", role: "Coach").present?
      true
    else
      false
    end
  end

  def is_athletic_director?
    if Classification.where(user_id: id, classification: "Athletic Director").present?
      true
    elsif Role.where(user_id: id, roleable_type: "School", status: "Active", role: "Athletic Director").present?
      true
    else
      false
    end
  end

  def shared_teams(user_id)
    user = User.find(user_id)
    user_team_ids = teams.pluck(:id)
    teammate_team_ids = user.teams.pluck(:id)
    user_team_ids & teammate_team_ids
  end

  def self.user_names
    array = []
    User.all.each do |user|
      array << "#{user.full_name}"
    end
    array
  end

  def self.user_json
    array = []
    User.all.each do |user|
      array << {id: user.id, name: user.full_name, link: Rails.env.production? ? "http://www.sportsmarkit.com/users/#{user.slug}" : "http://localhost:3000/users/#{user.slug}"}
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

  def classification_list_with_space(count=0)
    if count == 0
      classifications.pluck(:classification).join(",").gsub(" ", "-").gsub(","," ").downcase
    else
      classifications.pluck(:classification).first(count).join(" ")
    end
  end

  def certification_list(count=0)
    c = certificates.where('expiration >= ?', Time.now).pluck(:certification_id).uniq
    if count == 0
      Certification.where(id: c).pluck(:name).join(", ")
    else
      Certification.where(id: c).pluck(:name).first(count).join(", ")
    end
  end

  def has_profile_picture?
    user_profile_pictures.present?
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
    all_schools + all_teams
  end

  def lead_affiliation
    if all_schools.empty?
      all_teams.first
    else
      all_schools.first
    end
  end

  def image
    avatar
  end

  def name
    full_name
  end

  def chatroom_ids
    array = []
    rels = relationships.where.not(id: nil).each do |rel|
      rel.team.chatrooms.each do |chatroom|
        if rel.athlete? && chatroom.specific_id == 1
          array << chatroom.id
        end

        if rel.coach? && chatroom.specific_id == 2
          array << chatroom.id
        end

        if parent_relationship_with_team?(chatroom.team) && chatroom.specific_id == 3
          array << chatroom.id
        end
      end
    end
    array
  end

  def chatroom
    if relationships.where(accepted: true).present?
      rel = relationships.first
      rel.team.chatrooms.each do |chatroom|
        if rel.athlete? && chatroom.specific_id == 1
          return chatroom.id
        end

        if rel.coach? && chatroom.specific_id == 2
          return chatroom.id
        end

        if parent_relationship_with_team?(chatroom.team) && chatroom.specific_id == 3
          return chatroom.id
        end
      end
    end
  end

  def chatroom_group
  end


  def online?
    if online_status.present?
      -(online_status.last_seen - Time.now) < 300
    else
      false
    end
  end

  def self.generate_temporary_password(first_name)
    alpha = ('a'..'z').to_a
    first_part = first_name.delete(' ').downcase.reverse
    name_array = first_name.split("")
    array = []
    second_part = name_array.each do |letter|
      array << alpha.index(letter)
    end
    first_part.last(3) + array.join.last(5) + first_part.first(3)
  end

  def self.create_new_user_and_roster_spot(first_name,last_name, mobile_number, array, params)
    password = User.generate_temporary_password(first_name)
    new_user = User.new(first_name: first_name, last_name: last_name, mobile_phone_number: mobile_number, password: password)
    if new_user.save
      Rails.logger.info("New user created...")
      new_user.create_profile
      Rails.logger.info("New user profile created...")
      Role.create_new_roles(new_user.id, array, params)
      Rails.logger.info("New user role created...")
      User.send_mobile_invitation(new_user, password)
    end
  end

  def self.create_role_from_excel(params)
    password = User.generate_temporary_password(params[:first_name])
    if params[:mobile_phone_number].present?
      new_user = User.new(first_name: params[:first_name], last_name: params[:last_name], mobile_phone_number: params[:mobile_phone_number], password: password)
      new_user.save! unless User.exists?(mobile_phone_number: params[:mobile_phone_number])
      user = User.find_by_mobile_phone_number(params[:mobile_phone_number])
      user.create_profile unless Profile.exists?(user_id: user.id)
      Role.create_new_roles(user.id, ["Athlete"], params) unless Role.where(mobile_phone_number:  params[:mobile_phone_number], user_id: user.id, role: "Athlete", status: "Active", roleable_type: "Team", roleable_id: params[:team_id]).present?
    else
      UserlessRole.create_new_roles(["Athlete"], params)
    end
  end

  def self.send_mobile_invitation(user, password)
    Messanger.send_sms(user.mobile_phone_number, "#{user.first_name}, Coach has created your new team hub!
                http://www.sportsmarkit.com/login
                Login: #{user.mobile_phone_number}
                Password: #{password}")
  end


  def create_profile
    Profile.create(user_id: self.id, focus: [], specialties: [], skills: [], injuries: [], current_ailments: [])
  end

  def pending_object?(classification, object)
    roles.where(roleable: object, status: classification)
  end

  def fix_email
    self.email = email.to_s.downcase if is_parent?
  end

  def fix_phone
    self.mobile_phone_number = mobile_phone_number.to_s.gsub(/[^\d]/, "") if is_parent?
  end

  def attend_event?(event)
    attendees.where(event_id: event.id, yes: true).present?
  end

  def maybe_attend_event?(event)
    attendees.where(event_id: event.id, maybe: true).present?
  end

  def dont_attend_event?(event)
    attendees.where(event_id: event.id, no: true).present?
  end

  def hidden_phone_number
    last_4 = mobile_phone_number.last(4)
    "xxx-xxx-#{last_4}"
  end

  def find_registration(object)
    object.forms.where(submittable: self).last
  end

  def has_registered_for?(object)
    if find_registration(object).present?
      find_registration(object).paid?
    end
  end

  def has_incomplete_registration?(object)
    !has_registered_for?(object)
  end

  def all_registration_forms
    Form.where(submittable: self)
  end

  def self.user_type_subtitle(classification)
    classification
  end


end
