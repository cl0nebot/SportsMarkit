class AttendeesController < ApplicationController
  
  def create
    @attendee = Attendee.create(user_id: params[:attendee][:user_id], event_id: params[:attendee][:event_id], yes: params[:attendee][:yes], maybe: params[:attendee][:maybe], no: params[:attendee][:no])
    @attendee.save
    # @object = eval(@fan.fannable_type).find(@fan.fannable_id)
    # @class = @object.class
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def destroy
    @attendee = Attendee.find(params[:id])
    # @object = eval(@fan.fannable_type).find(@fan.fannable_id)
#     @class = @object.class
    @attendee.destroy
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  
end
