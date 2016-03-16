class EventSchedulesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_filter :find_event_schedule, except: :index

  def index
    respond_to do |format|
      format.json {
        render json: Event.find(params[:event_id]).event_schedules
      }
    end
  end

  def show
    presenter = EventPresenter.new(@event_schedule, current_user)
    @attendees = presenter.attendees
    @maybes = presenter.maybes
    @nos = presenter.nos
    @facility = presenter.facility
    @json = @facility.address.to_gmaps4rails
    gon.push(presenter.user_visits)
    render 'events/show'
  end

  def attend
    attendee = Attendee.find_or_initialize_by(event_schedule_id: @event_schedule.id, user_id: current_user.id)
    attendee.assign_attributes(yes: nil, maybe: nil, no: nil)
    attendee.assign_attributes(params[:attend_type].to_sym => true)
    attendee.save
    respond_to do |format|
      format.json {
        render json: { status: :ok, id: attendee.event_schedule_id, type: params[:attend_type] }
      }
    end
  end

  def find_event_schedule
    @event_schedule = EventSchedule.find(params[:id])
  end
end