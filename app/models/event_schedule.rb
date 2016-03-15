class EventSchedule < ActiveRecord::Base
  belongs_to :event

  has_many :attendees, dependent: :destroy

  scope :upcoming, -> { where('ends_at >= ?', Time.now).order('starts_at ASC') }

  delegate :title, :event_type, :user, to: :event
end