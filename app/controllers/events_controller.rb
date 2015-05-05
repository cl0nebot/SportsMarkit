class EventsController < ApplicationController
  before_action :find_object, except: [:show]
  before_action :find_event, only: [:edit, :update, :destroy]
  
  def index
    @events = @object.events
  end
  
  def new
    @event = @object.events.build
  end
  
  def create
    @event = @object.events.build(event_params)
    if @event.save
      EventFacility.create(event_id: @event.id, facility_id: params[:event][:facility_ids])
      redirect_to @event
    else
      render 'new'
    end
  end
  
  def show
    @event = Event.friendly.find(params[:id])
    @attendees = @event.attendees.where(yes: true)
    @maybes = @event.attendees.where(maybe: true)
    @nos = @event.attendees.where(no: true)
    @json = @event.facility.to_gmaps4rails
  end
  
  def edit
    
  end
  
  def update
    if @event.update_attributes(event_params)
      redirect_to events_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @event.destroy
    redirect_to events_path
    #add twilio
  end
  
  protected
  
  def event_params
    params.require(:event).permit(:user_id, :eventable_id, :eventable_type, :event_type, :title, :starts_at, :ends_at, :all_day, :description, :private, :created_by)
  end
  
  def find_object
    if ((params["action"] == "create" || params["action"] == "update"))
      @class = eval(request.referrer.split("/")[3].to_s.capitalize.singularize.split("_").first)
    else
      @class = eval(params.keys[2].to_s.capitalize.split("_").first)
    end
    @id = params[params.keys.last]
    @object = @class.friendly.find(@id)
  end
  
  def find_event
    @event = @object.events.find(params[:id])
  end
  
end
