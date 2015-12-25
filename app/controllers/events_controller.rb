require "teams_controller"
class EventsController < ApplicationController
  before_action :authenticate_user!
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
      Connect.create(ownerable_id: @event.id, ownerable_type: "Event", connectable_type: "Facility", connectable_id: params[:event][:facility_ids])
      if @event.eventable_type == "Team"
        user_ids = Team.find(@event.eventable_id).roles.where(status: "Active").pluck(:user_id).uniq
        user_ids.each do |i|
          Attendee.create(user_id: i, event_id: @event.id, yes: true)
        end
      end
      @event.name_and_phone_numbers.each do |obj|
        receiving_number = obj.last

        twilio_sid = ENV['TWILIO_SID']
        twilio_token = ENV['TWILIO_AUTH_TOKEN']
        twilio_phone_number = "2027590519"
        @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
      begin
        @twilio_client.account.sms.messages.create(
          :from => "+1#{twilio_phone_number}",
          :to => receiving_number,
          :body => "Hello #{obj.first}! A new #{@event.event_type} has been created: #{@event.title} "
        )
      rescue Twilio::REST::RequestError => e
        puts e.message
      end
      
      end
      
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
    @facility = @event.facility
    @json = @facility.to_gmaps4rails
    
  end
  
  def edit
    @event = Event.friendly.find(params[:id])
    
  end
  
  def update
    @event = Event.friendly.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end
  
  def destroy
    @event = Event.friendly.find(params[:id])
    @object_type = @event.eventable_type
    @object_id = @event.eventable_id
    @object = @object_type.constantize.find(@object_id)
    @event.name_and_phone_numbers.each do |obj|
      receiving_number = obj.last

      twilio_sid = ENV['TWILIO_SID']
      twilio_token = ENV['TWILIO_AUTH_TOKEN']
      twilio_phone_number = "2027590519"
      @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
      
      @twilio_client.account.sms.messages.create(
        :from => "+1#{twilio_phone_number}",
        :to => receiving_number,
        :body => "Hello #{obj.first}! Your event #{@event.title} has been canceled."
      )
      
    end
    
    @event.destroy
    redirect_to eval("new_#{@object_type.downcase}_event_path(@object.friendly_id)")
  end
  
  def rsvp
    @event = Event.find(params[:event_id])
    @user = User.find(params[:user_id])
    boolean = params[:rsvp]
    rsvp = Attendee.find_or_initialize_by(event_id: @event.id, user_id: @user.id)
    rsvp.update_attributes(yes: nil, maybe: nil, no: nil)
    rsvp.update_attributes(boolean.to_sym => true)
    @attendees = @event.attendees.where(yes: true)
    @maybes = @event.attendees.where(maybe: true)
    @nos = @event.attendees.where(no: true)
    respond_to do |format|
      format.html{redirect_to :back}
      format.js
    end  
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
