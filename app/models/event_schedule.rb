class EventSchedule < ActiveRecord::Base
  belongs_to :event

  has_many :attendees, dependent: :destroy

  scope :upcoming, -> { where('ends_at >= ?', Time.now).order('starts_at ASC') }

  delegate :title, :event_type, :description, :user, :facility, :eventable, :eventable_type, :can_be_edited_by_user?, to: :event

  def as_json(options={})
    {
      id: id,
      event_id: event_id,
      title: title,
      class: "event-important",
      start: starts_at.to_datetime.strftime('%Q'),
      end: ends_at.to_datetime.strftime('%Q')
    }
  end
end