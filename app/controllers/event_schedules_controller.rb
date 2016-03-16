class EventSchedulesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_event_schedule

  def show
    @event.starts_at = @event_schedule.starts_at
    @event.ends_at = @event_schedule.ends_at
    @attendees = @event_schedule.attendees.where(yes: true)
    @maybes = @event_schedule.attendees.where(maybe: true)
    @nos = @event_schedule.attendees.where(no: true)
    @facility = @event.facility
    @json = @facility.address.to_gmaps4rails
  end

  private

  def find_event_schedule
    @event = Event.friendly.find(params[:event_id])
    @event_schedule = @event.event_schedules.find(params[:id])
  end
end