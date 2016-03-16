class EventSchedulesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_event
  before_action :find_event_schedule, except: :index

  def index
    @event_schedules = @event.event_schedules
    respond_to do |format|
      format.json {
        render json: @event_schedules
      }
    end
  end

  def show
    @event.starts_at = @event_schedule.starts_at
    @event.ends_at = @event_schedule.ends_at
    @attendees = @event_schedule.attendees.where(yes: true)
    @maybes = @event_schedule.attendees.where(maybe: true)
    @nos = @event_schedule.attendees.where(no: true)
    @facility = @event.facility
    @json = @facility.address.to_gmaps4rails
  end

  def attend
    attendee = Attendee.find_or_initialize_by(event_schedule_id: @event_schedule.id, user_id: current_user.id)
    attendee.assign_attributes(yes: nil, maybe: nil, no: nil)
    attendee.assign_attributes(params[:attend_type].to_sym => true)
    attendee.save
    respond_to do |format|
      format.json {
        render json: ""
      }
    end
  end

  private

  def find_event
    @event = Event.friendly.find(params[:event_id])
  end

  def find_event_schedule
    @event_schedule = @event.event_schedules.find(params[:id])
  end
end