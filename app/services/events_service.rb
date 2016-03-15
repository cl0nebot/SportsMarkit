class EventsService
  def initialize(object, params)
    @object = object
    @params = params
  end

  def create
    @event = @object.events.build(event_params)
    @event.opponent_type = "Team"
    if @event.save
      create_event_schedules
      create_connection
      create_attendees
      send_notifications
    end

    @event
  end

  private

  def create_event_schedules
    @event.event_schedules.destroy_all
    if @event.single?
      @event.event_schedules.create(starts_at: @event.starts_at, ends_at: @event.ends_at)
    else
      match = @event.repeat_type.match /every_(\w+)/
      return unless match[1]
      interval = 1.send(match[1])
      starts_at = @event.starts_at
      ends_at = @event.ends_at
      while ends_at <= @event.repeat_until
        @event.event_schedules.create(starts_at: starts_at, ends_at: ends_at)
        starts_at += interval
        ends_at += interval
      end
    end
  end

  def create_connection
    Connect.create(ownerable: @event, connectable_type: "Facility", connectable_id: @params[:event][:facility_ids])
  end

  def create_attendees
    if @event.eventable_type == "Team"
      user_ids = Team.find(@event.eventable_id).roles.where(status: "Active").pluck(:user_id)
      opponent_ids = Team.find(@event.opponent_id).roles.where(status: "Active").pluck(:user_id)
      all_ids = (user_ids + opponent_ids).uniq
      @event.event_schedules.each do |event_schedule|
        all_ids.each do |i|
          Attendee.create(user_id: i, event_schedule: event_schedule, yes: true)
        end
      end
    end
  end

  def send_notifications
    @event.name_and_phone_numbers.each do |obj|
      receiving_number = obj.last

      twilio_sid = ENV['TWILIO_SID']
      twilio_token = ENV['TWILIO_AUTH_TOKEN']
      twilio_phone_number = "2027590519"
      begin
        @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
        @twilio_client.account.messages.create(
          :from => "+1#{twilio_phone_number}",
          :to => receiving_number,
          :body => "Hello #{obj.first}! A new #{@event.event_type} has been created: #{@event.title} "
        )
      rescue Twilio::REST::RequestError => e
        puts e.message
      end
    end
  end

  def event_params
    @params.require(:event).permit(:user_id, :eventable_id, :eventable_type,
                                  :opponent_id, :opponent_type, :event_type, :title, :starts_at, :ends_at,
                                  :all_day, :description, :private, :created_by, :reservation, :repeat_type,
                                  :repeat_until, facility_ids: [])
  end
end
