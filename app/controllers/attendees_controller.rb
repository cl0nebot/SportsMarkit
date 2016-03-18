class AttendeesController < ApplicationController

  def create
    @attendee = Attendee.create(user_id: params[:attendee][:user_id], event_id: params[:attendee][:event_id], yes: params[:attendee][:yes], maybe: params[:attendee][:maybe], no: params[:attendee][:no])
    @user = User.friendly.find(params[:attendee][:user_id])
    @attendee.save
    @event = Event.find(params[:attendee][:event_id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    @attendee = Attendee.find(params[:id])
    @attendee.update_attributes(user_id: params[:attendee][:user_id], event_id: params[:attendee][:event_id], yes: params[:attendee][:yes], maybe: params[:attendee][:maybe], no: params[:attendee][:no])
    @user = User.friendly.find(params[:attendee][:user_id])
    @event = Event.find(params[:attendee][:event_id])
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
