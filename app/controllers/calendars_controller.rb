class CalendarsController < ApplicationController
  def show
  end

  def events
    @events = User.find(params[:user_id]).all_events
    @events = @events.between(params['start'], params['end']) if (params['start'] && params['end'])
    render json: @events
  end
end