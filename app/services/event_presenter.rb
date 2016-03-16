require 'gon'

class EventPresenter
  attr_accessor :event, :schedule

  delegate :facility, :event_id, to: :@event_schedule

  def initialize(event_schedule, user)
    @event_schedule = event_schedule
    @user = user
  end

  def user_visits
   {
      visiting_ids: {
          no: @user.event_schedules.joins(:attendees).where(attendees: { no: true }, event_id: event_id).pluck(:id),
          maybe: @user.event_schedules.joins(:attendees).where(attendees: { maybe: true }, event_id: event_id).pluck(:id),
          yes: @user.event_schedules.joins(:attendees).where(attendees: { yes: true }, event_id: event_id).pluck(:id)
      }
   }
  end

  def all_attendees
    @event_schedule.attendees
  end

  def attendees
    all_attendees.where(yes: true)
  end

  def maybes
    all_attendees.where(maybe: true)
  end

  def nos
    all_attendees.where(no: true)
  end
end