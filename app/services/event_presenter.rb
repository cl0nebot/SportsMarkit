require 'gon'

class EventPresenter
  attr_accessor :event, :schedule

  delegate :facility, to: :@event

  def initialize(event, user)
    @event = event
    @user = user
  end

  def user_visits
   {
      visiting_ids: {
          no: @user.attendees.where(no: true, event_id: similar_ids).pluck(:event_id),
          maybe: @user.attendees.where(maybe: true, event_id: similar_ids).pluck(:event_id),
          yes: @user.attendees.where(yes: true, event_id: similar_ids).pluck(:event_id)
      }
   }
  end

  def similar_ids
    @similar_ids ||= @event.similar.pluck(:id)
  end

  def all_attendees
    @event.attendees
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