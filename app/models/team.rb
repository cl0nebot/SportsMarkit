class Team < ActiveRecord::Base
  extend FriendlyId
  include Images
  include Shared
  include Roster
  include EventDetail
  include Common
  include Access
  include Map
  include Import

  friendly_id :use_for_slug, use: [:slugged, :finders]
  
  belongs_to :teamable, polymorphic: true
  
  has_many :forms, as: :formable, dependent: :destroy
  has_many :roles, as: :roleable, dependent: :destroy
  has_many :userless_roles, as: :userless, dependent: :destroy
 
  #belongs_to :school
  has_many :events, as: :eventable
  has_many :team_leagues
  
  has_many :users, through: :roles
  
  has_many :chatrooms
  
  validates :sport, presence: true
  validates :name, presence: true
  
  has_many :leagues, through: :team_leagues
  
  before_update :update_slug
  
  has_many :documents, as: :documentable, dependent: :destroy

  def use_for_slug
    existing_team = Team.where('slug = ?', self.slug)
    if existing_team.present?
      "#{name} #{self.teamable.name if self.teamable.present?} #{sport} #{self.address.city if self.address.present?} #{existing_team.count}"
    else
      "#{name} #{self.teamable.name if self.teamable.present?} #{sport} #{self.address.city if self.address.present?} "
    end
  end
  
  def update_slug
    if (name_changed? || address.city_changed?)
      existing_team = self.minus_self.where('slug = ?', self.slug)
      teamable = self.teamable.present? ? self.teamable.name : nil
      if existing_team.present?
        update_column(:slug, "#{ApplicationController.helpers.to_slug(name, teamable, sport, address.city, existing_team.count)}")
      else
        update_column(:slug, "#{ApplicationController.helpers.to_slug(name, teamable, sport, address.city)}")
      end
    end
  end
  
  def minus_self
    Team.where.not(id: id)
  end
  
  
  def self.with_schools
    Team.where(teamable_type: "School")
  end
  
  def self.school_team_names
    array = []
    Team.with_schools.each do |team|
      array << "#{team.teamable.name} #{team.name}"
    end
    array
  end

  def self.without_schools
   club_teams = Team.where(teamable_type: "Club").pluck(:id)
   indy_teams = Team.where(teamable_type: nil).pluck(:id)
   Team.where(id: (club_teams + indy_teams).uniq)
  end

  def self.non_school_team_names
    array = []
    Team.without_schools.each do |team|
      array << "#{team.name}"
    end
    array
  end
    
  def with_school_name
    "#{teamable.name} #{name}"
  end
    
  def last_chat_stream_message_id
    Message.where(chatroom_id: id).last.find_beginning_of_stream
  end
  
  
  def classification_and_category
    if teamable.present?
      teamable_class = teamable.category_and_classification
    end
    
    if classification.present?
      self_class = classification.downcase.gsub("recreational: ","").gsub(" ","-")
    end
    
    if teamable_class.nil? 
      self_class
    elsif self_class.nil?
      teamable_class
    else
      teamable_class + self_class
    end
  end
  
  def self.type_with_hyphen(type)
    type.downcase.gsub("recreational: ","").gsub(" ","-")
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
