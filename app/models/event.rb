class Event < ActiveRecord::Base
  # scope :between, ->(start_time, end_time){ where("? < starts_at < ?", Event.format_date(start_time), Event.format_date(end_time)) }
  # scope :between, lambda {{ :conditions => ["starts_at >= ? AND starts_at <= ?", Event.format_date(start_time), Event.format_date(end_time)] }}
  belongs_to :eventable, polymorphic: true
  belongs_to :user
  extend FriendlyId
  friendly_id :use_for_slug, use: [:slugged, :finders]
  has_many :attendees, dependent: :destroy
  
  has_one :event_facility, dependent: :destroy
  has_one :facility, through: :event_facility
  
  def self.between(start_time, end_time)
    where('starts_at >= ?', Event.format_date(start_time)).where('starts_at <= ?', Event.format_date(end_time)).where.not('starts_at > ?', Event.format_date(end_time)).uniq
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
        :url => Rails.application.routes.url_helpers.event_path(id),
        #:color => "red"
    }
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

end
