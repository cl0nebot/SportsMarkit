class AttendeesController < ApplicationController

  def create
    @attendee = Attendee.create(user_id: params[:attendee][:user_id], event_schedule_id: params[:attendee][:event_schedule_id], yes: params[:attendee][:yes], maybe: params[:attendee][:maybe], no: params[:attendee][:no])
    @user = User.friendly.find(params[:attendee][:user_id])
    @attendee.save
    @event_schedule = EventSchedule.find(@attendee.event_schedule_id)
    @event = @event_schedule.event
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    @attendee = Attendee.find(params[:id])
    @attendee.update_attributes(user_id: params[:attendee][:user_id], event_schedule_id: params[:attendee][:event_schedule_id], yes: params[:attendee][:yes], maybe: params[:attendee][:maybe], no: params[:attendee][:no])
    @user = User.friendly.find(params[:attendee][:user_id])
    @event_schedule = EventSchedule.find(@attendee.event_schedule_id)
    @event = @event_schedule.event
    respond_to do |format|
      format.js
      format.html
    end
  end

  def destroy
    @attendee = Attendee.find(params[:id])
    @attendee.destroy
    respond_to do |format|
      format.js
      format.html
    end
  end


end
