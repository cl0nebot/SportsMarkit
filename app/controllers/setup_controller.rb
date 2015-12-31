class SetupController < ApplicationController
  before_action :find_user, except: [:test_setup, :delete_role, :add_role]
  
  def setup
    @athlete_teams = Team.where.not(id: @user.relationships.where(participant: true).pluck(:team_id)).limit(20)
    @coach_teams = Team.where.not(id: @user.relationships.where(head: true).pluck(:team_id)).limit(20)
    @athletes = User.athletes.limit(20)
  end
  
  def overview
  end
  
  def add_role
    @user = User.friendly.find(params[:user_id])
    role = Role.create(user_id: params[:user_id], role: params[:role], roleable_id: params[:roleable_id], roleable_type: params[:roleable_type], status: params[:status])
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def delete_role
    @user = User.friendly.find(params[:user_id])
    @role = Role.find(params[:role_id])
    @role.destroy
    respond_to do |format|
      format.js
      format.html
    end
  end

  protected
  
  def find_user
    @user = User.friendly.find(params[:id])
  end
  
end
