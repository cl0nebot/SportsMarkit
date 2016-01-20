class Event < ActiveRecord::Base
  # scope :between, ->(start_time, end_time){ where("? < starts_at < ?", Event.format_date(start_time), Event.format_date(end_time)) }
  # scope :between, lambda {{ :conditions => ["starts_at >= ? AND starts_at <= ?", Event.format_date(start_time), Event.format_date(end_time)] }}
  belongs_to :eventable, polymorphic: true
  belongs_to :user
  include Access
  extend FriendlyId
  friendly_id :use_for_slug, use: [:slugged, :finders]
  has_many :attendees, dependent: :destroy
  
  def fake_id
    @fake_id ||= id || SecureRandom.hex
  end
  
  has_one :event_facility, dependent: :destroy
  has_many :connects, as: :ownerable, dependent: :destroy 
  
  def self.between(start_time, end_time)
    where('starts_at >= ?', Event.format_date(start_time)).where('starts_at <= ?', Event.format_date(end_time)).where.not('starts_at > ?', Event.format_date(end_time)).uniq
  end
  
  def self.upcoming_events
    where('ends_at >= ?', Time.now).order('starts_at ASC')
  end
  
  def use_for_slug
    existing_event = Event.where('slug = ?', self.slug)
    if existing_event.present?
      "#{Time.now.to_i} #{self.title} #{existing_event.count}"
    else
      "#{Time.now.to_i} #{self.title}"
    end
  end

  def as_json(options = {})
    {
        :id => self.id,
        :title => self.title,
        :description => self.description || "",
        :start => starts_at.localtime.strftime('%Y-%m-%d %H:%M'),
        :end => ends_at.localtime.strftime('%Y-%m-%d %H:%M'),
        :allDay => self.all_day,
        :recurring => false,
        #:url => Rails.application.routes.url_helpers.event_path(),
        :url => "/events/#{self.slug}",
        :color => self.color
    }
  end
  
  def color
    if ["Game", "Track Meet"].include? event_type 
      "red"
    elsif ["Practice"].include? event_type
      "blue"
    elsif ["Scrimmage"].include? event_type
      "grey"
    elsif ["Meeting", "Banquet"].include? event_type
      "purple"
    end
  end

  def self.format_date(date_time)
    Time.parse(date_time).to_formatted_s(:db)
  end

  def reservation=(val)
    starts, ends = val.split('-')
    self.starts_at = Time.strptime(starts.strip, '%m/%d/%Y %H:%M %P')
    self.ends_at = Time.strptime(ends.strip, '%m/%d/%Y %H:%M %P')
  end
  
  def people_that_are_going
    attendees.where(yes: true)
  end
  
  def name_and_phone_numbers
    array = []
    attendees.each do |att|
      array << [att.user.first_name, att.user.mobile_phone_number] 
    end
    array
  end
  
  def facility
    Facility.find(connects.where(connectable_type: "Facility").last.connectable_id)
  end
  
  def proper_facility_name
    if facility.school.present?
      "#{facility.school.name} #{facility.name}"
    else
      "#{facility.name}"
    end
  end
  
  def proper_facility_name_and_location
    if facility.school.present?
      "#{facility.school.name} #{facility.name}, #{facility.address.city_and_state}"
    else
      "#{facility.name} #{facility.address.city_and_state}"
    end
    
  end

end
