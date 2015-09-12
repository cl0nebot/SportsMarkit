module EventDetail
  extend ActiveSupport::Concern
  
  def all_events
    upcoming_events
  end
  
  def next_event
    upcoming_events.first.nil? ? "No upcoming events" : upcoming_events.first.title
  end
  
  def upcoming_events
    if self.class.to_s == "User"
      all_events.where('ends_at >= ?', Time.now).sort_by(&:starts_at)
    elsif self.class.to_s == "School"
      Event.where(eventable_type: "Team", eventable_id: team_ids).where('ends_at >= ?', Time.now).sort_by(&:starts_at)
    elsif self.class.to_s == "League"
      team_ids = TeamLeague.where(league_id: id).pluck(:team_id)
      team_events_ids = Event.where(eventable_type: "Team", eventable_id: team_ids).where('ends_at >= ?', Time.now).pluck(:id)
      league_events_ids = Event.where(eventable_type: "League", eventable_id: id).where('ends_at >= ?', Time.now).pluck(:id)
      events = Event.where(id: team_events_ids + league_events_ids ).uniq.sort_by(&:starts_at)
    elsif self.class.to_s == "Team"
      Event.where(eventable_type: "Team", eventable_id: id).where('ends_at >= ?', Time.now).sort_by(&:starts_at)
    elsif self.class.to_s == "Facility" 
      event_ids = EventFacility.where(facility_id: id).pluck(:event_id)
      events = Event.where(id: event_ids ).where('ends_at >= ?', Time.now).sort_by(&:starts_at)
    end
  end
  
 
  
  
end
