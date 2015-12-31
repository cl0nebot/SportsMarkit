module EventDetail
  extend ActiveSupport::Concern
    
  def next_event
    upcoming_events.first.nil? ? "No upcoming events" : upcoming_events.first.title
  end
  
  def all_events
    if self.class.to_s == "User"
      school_ids = user_schools.pluck(:id)
      team_ids = user_teams.pluck(:id)
      school_events = Event.where(eventable_type: "School", eventable_id: school_ids).pluck(:id)
      team_events = Event.where(eventable_type: "Team", eventable_id: team_ids).pluck(:id)
      opponent_team_events = Event.where(opponent_type: "Team", opponent_id: team_ids).pluck(:id)
      user_events = self.events.pluck(:id)
      events = Event.where(id: (school_events + team_events + user_events + opponent_team_events).uniq)
    elsif self.class.to_s == "School"
      school = Event.where(eventable_type: "School", eventable_id: id).pluck(:id)
      school_team = Event.where(eventable_type: "Team", eventable_id: team_ids).pluck(:id)
      opponent_school_team = Event.where(opponent_type: "Team", opponent_id: team_ids).pluck(:id)
      Event.where(id: (school + school_team + opponent_school_team).uniq)
    elsif self.class.to_s == "League"
      team_ids = Connect.where(ownerable_type: "Team", connectable_id: id, connectable_type: "League").pluck(:ownerable_id)
      team_events_ids = Event.where(eventable_type: "Team", eventable_id: team_ids).pluck(:id)
      opponent_team_events_ids = Event.where(opponent_type: "Team", opponent_id: team_ids).pluck(:id)
      league_events_ids = Event.where(eventable_type: "League", eventable_id: id).pluck(:id)
      events = Event.where(id: (team_events_ids + league_events_ids + opponent_team_events_ids).uniq )
    elsif self.class.to_s == "Team"
      team = Event.where(eventable_type: "Team", eventable_id: id).pluck(:id)
      opponent = Event.where(opponent_type: "Team", opponent_id: id).pluck(:id)
      Event.where(id: (team + opponent).uniq)
    elsif self.class.to_s == "Facility" 
      event_ids = Connect.where(eventable_type: "Event", connectable_id: id, connectable_type: "Facility").pluck(:eventable_id)
      events = Event.where(id: event_ids )
    elsif self.class.to_s == "Club"
      club = Event.where(eventable_type: "Club", eventable_id: id).pluck(:id)
      club_team = Event.where(eventable_type: "Team", eventable_id: team_ids).pluck(:id)
      opponent_club_team = Event.where(opponent_type: "Team", opponent_id: team_ids).pluck(:id)
      Event.where(id: (club_team + opponent_club_team + club).uniq )
    end
  end
  
  def upcoming_events
    all_events.where('ends_at >= ?', Time.now).order('starts_at ASC')
  end
  
 
  
  
end
