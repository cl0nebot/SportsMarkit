require "teams_controller"
class EventsController < ApplicationController
  before_action :find_object, except: [:show, :destroy, :edit, :update]
  require 'twilio-ruby'
  
  def index
    @events = @object.events
    @user = User.friendly.find(params[:user_id])
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
    @event = Event.friendly.find(params[:id])
    
  end
  
  def update
    @event = Event.friendly.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to events_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @event = Event.friendly.find(params[:id])
    @event.name_and_phone_numbers.each do |obj|
      receiving_number = obj.last

      twilio_sid = ENV['TWILIO_SID']
      twilio_token = ENV['TWILIO_AUTH_TOKEN']
      twilio_phone_number = "2025179077"
      @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
      
      @twilio_client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => receiving_number,
        :body => "Hello #{obj.first}! Your event #{@event.title} has been canceled."
      )
      
    end
    
    @event.destroy
    redirect_to new_user_event_path(current_user)
    #add twilio
  end
  
  protected
  
  def event_params
    params.require(:event).permit(:user_id, :eventable_id, :eventable_type, :event_type, :title, :starts_at, :ends_at, :all_day, :description, :private, :created_by, :reservation)
  end
  
  def find_object
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @object = $1.capitalize.constantize.find(params[param])
  end
  
  def find_event
    @event = @object.events.find(params[:id])
  end
  
end
