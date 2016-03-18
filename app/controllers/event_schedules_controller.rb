class EventSchedulesController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def index
    respond_to do |format|
      format.json {
        render json: Event.find(params[:event_id]).similar.all, each_serializer: CalendarEventSerializer, root: false
      }
    end
  end
end