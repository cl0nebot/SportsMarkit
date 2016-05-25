class EventsService
  def initialize(object, params)
    @object = object
    @params = params
  end

  def create
    @event = @object.events.build(event_params)
    @event.opponent_type = "Team"
    if @event.save
      @events = [@event]
      create_child_events
      create_connections
      create_attendees
      send_notifications
    end

    @event
  end

  private

  def create_child_events
    return if @event.single?
    match = @event.repeat_type.match /every_(\w+)/
    return unless match[1]
    interval = 1.send(match[1])
    starts_at = @event.starts_at + interval
    ends_at = @event.ends_at + interval
    while ends_at <= @event.repeat_until
      event = @event.dup
      event.assign_attributes(starts_at: starts_at, ends_at: ends_at, repeat_type: 0, repeat_until: nil, parent_id: @event.id)
      event.save
      @events << event
      starts_at += interval
      ends_at += interval
    end
  end

  def create_connections
    @events.each{ |event| create_connection(event) }
  end

  def create_connection(event)
    Connect.create(ownerable: event, connectable_type: "Facility", connectable_id: @params[:event][:facility_ids])
  end

  def create_attendees
    if @event.eventable_type == "Team"
      user_ids = Team.find(@event.eventable_id).roles.where(status: "Active").pluck(:user_id)
      opponent_ids = @event.opponent_id.present? ? Team.find(@event.opponent_id).roles.where(status: "Active").pluck(:user_id) : []
      all_ids = (user_ids + opponent_ids).uniq
      @events.flatten.each do |event|
        all_ids.each do |i|
          Attendee.create(user_id: i, event_id: event.id, yes: true)
        end
      end
    end
  end

  def send_notifications
    @event.name_and_phone_numbers.each do |obj|
      Messanger.send_sms(obj.last, "Hello #{obj.first}! A new #{@event.event_type} has been created: #{@event.title} ")
    end
  end

  def event_params
    @params.require(:event).permit(:user_id, :eventable_id, :eventable_type, :file,
                                  :opponent_id, :opponent_type, :event_type, :title, :starts_at, :ends_at,
                                  :all_day, :description, :private, :created_by, :reservation, :repeat_type,
                                  :registration_required, :repeat_until, facility_ids: [])
  end
end
