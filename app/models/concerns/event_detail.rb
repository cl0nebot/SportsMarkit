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
      school_ids = user_schools.pluck(:id)
      team_ids = user_teams.pluck(:id)
      school_events = Event.where(eventable_type: "School", eventable_id: school_ids).where('ends_at >= ?', Time.now).order('starts_at ASC')
      team_events = Event.where(eventable_type: "Team", eventable_id: team_ids).where('ends_at >= ?', Time.now).order('starts_at ASC')
      user_events = self.events.where('ends_at >= ?', Time.now).order('starts_at ASC')
      events = (school_events + team_events + user_events).uniq
    elsif self.class.to_s == "School"
      Event.where(eventable_type: "Team", eventable_id: team_ids).where('ends_at >= ?', Time.now).order('starts_at ASC')
    elsif self.class.to_s == "League"
      team_ids = TeamLeague.where(league_id: id).pluck(:team_id)
      team_events_ids = Event.where(eventable_type: "Team", eventable_id: team_ids).pluck(:id)
      league_events_ids = Event.where(eventable_type: "League", eventable_id: id).pluck(:id)
      events = Event.where(id: team_events_ids + league_events_ids ).order('starts_at ASC').uniq
    elsif self.class.to_s == "Team"
      Event.where(eventable_type: "Team", eventable_id: id).where('ends_at >= ?', Time.now).order('starts_at ASC')
    elsif self.class.to_s == "Facility" 
      event_ids = EventFacility.where(facility_id: id).pluck(:event_id)
      events = Event.where(id: event_ids ).where('ends_at >= ?', Time.now).order('starts_at ASC')
    end
  end
  
 
  
  
end
