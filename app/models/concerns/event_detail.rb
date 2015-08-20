module EventDetail
  extend ActiveSupport::Concern
  
  def all_events
    upcoming_events
  end
  
  def next_event
    upcoming_events.first.nil? ? "No upcoming events" : upcoming_events.first.title
  end
  
end
