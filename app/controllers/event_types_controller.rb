class EventTypesController < ApplicationController
  
  
  def index
    @event_types = EventType.all
    @event_type = EventType.new
  end
  
  def create
    @event_type = EventType.new(event_type_params)
    if @event_type.save
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      flash.now[:error] = @event_type.errors.full_messages
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    end
  end
  
  def update
    @event_type = EventType.find(params[:id])
    @index = @event_type.index_position
    @before_item = @index - 1
    @result = @event_type.update_attributes(event_type_params)
    if @result
      flash[:success] = "Event Type has been updated."
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    else
      flash.now[:error] = @event_type.errors.full_messages
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    end
  end
  
  def destroy
    @event_type = EventType.find(params[:id])
    @index =  @event_type.index_position
    @event_type.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  
  protected
  
  def event_type_params
    params.require(:event_type).permit(:event_type, :sport_id)
  end
end
  
