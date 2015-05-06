class CalendarsController < ApplicationController
  before_filter :set_eventable

  def show
    @all_events = @eventable.all_events
  end

  def events
    @events = @eventable.all_events
    @events = @events.between(params['start'], params['end']) if (params['start'] && params['end'])
    @events = @events.ransack(params[:q]).result
    render json: @events
  end

  private

  def set_eventable
    param = params.keys.find{|key| key =~ /(\w+)_id/}
    @eventable = $1.capitalize.constantize.find(params[param])
  end
end