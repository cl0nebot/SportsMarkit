class RsvpService
  include Rails.application.routes.url_helpers

  def initialize(user, event, params)
    @user = user
    @event = event
    @boolean = params[:rsvp]
    reset_rsvp
    attend_rsvp
  end

  def rsvp
    @rsvp ||= Attendee.find_or_initialize_by(event_id: @event.id, user_id: @user.id)
  end

  def reset_rsvp
    rsvp.update_attributes(yes: nil, maybe: nil, no: nil)
  end

  def attend_rsvp
    @rsvp.update_attributes(@boolean.to_sym => true) unless need_to_pay?
  end

  def attendees
    @event.attendees.where(yes: true)
  end

  def maybes
    @event.attendees.where(maybe: true)
  end

  def nos
    @event.attendees.where(no: true)
  end

  def need_to_pay?
    @boolean == 'yes' && @event.payment_required? && !@user.has_registered_for?(@event)
  end

  def registration
    @registration ||= @user.find_registration(@event)
  end

  def registered_for_event?
    registration.present?
  end

  def event_name
    @event.name
  end

  def redirect_url
    if registered_for_event?
      event_registration_register_path(event_id: @event.id, registration_id: @registration.id)
    else
      new_event_registration_path(@event)
    end
  end
end