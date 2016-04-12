class InvitesController < ApplicationController
  before_action :find_object

  def index
  end

  def create
    params[:role][:role].each do |role|
      r = Role.new(role_params)
      r.roleable = @object
      r.role = role
      r.save
    end
    redirect_to :back
  end

  private

  def role_params
    params.require(:role).permit(:user_id, :roleable_id, :roleable_type,
      :mobile_phone_number, :level, :nickname)
  end

  def find_object
    id_column = (["school_id", "team_id", "facility_id", "club_id", "league_id", "event_id"] & params.keys)[0]
    klass = id_column.match(/([\w_]+)_id/)[1].capitalize.constantize
    @object = klass.find(params[id_column])
  end
end