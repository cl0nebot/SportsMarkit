class CalendarsController < ApplicationController
  before_action :set_user

  def show
    @all_events = @user.all_events.includes(:user)
  end

  def events
    @events = @user.all_events
    @events = @events.between(params['start'], params['end']) if (params['start'] && params['end'])
    @events = @events.ransack(params[:q]).result
    render json: @events
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end