class SetupController < ApplicationController
  before_action :find_user, except: [:test_setup, :delete_role, :add_role]
  
  def setup
    @athlete_teams = Team.where.not(id: @user.relationships.where(participant: true).pluck(:team_id)).limit(20)
    @coach_teams = Team.where.not(id: @user.relationships.where(head: true).pluck(:team_id)).limit(20)
    @athletes = User.athletes.limit(20)
  end
  
  def overview
  end
  
  def test_setup
    @athletes = User.athletes
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
  
  
  # def athlete_setup
#     @team_ids = @user.relationships.where(participant: true).pluck(:team_id)
#     @adjusted_team_ids = @team_ids + params[:user][:team_ids].drop(1)
#     #create relationship
#     @adjusted_team_ids.each do |id|
#       relationship = Relationship.find_or_create_by(user_id: @user.id, team_id: id)
#       relationship.update_attributes(participant: true)
#     end
#     respond_to do |format|
#       format.js
#       format.html { redirect_to :back }
#     end
#   end
#
#   def coach_setup
#     @team_ids = @user.relationships.where(head: true).pluck(:team_id)
#     @adjusted_team_ids = @team_ids + params[:user][:team_ids].drop(1)
#     #create relationship
#     @adjusted_team_ids.each do |id|
#       relationship = Relationship.find_or_create_by(user_id: @user.id, team_id: id)
#       relationship.update_attributes(head: true)
#     end
#     respond_to do |format|
#       format.js
#       format.html { redirect_to :back }
#     end
#   end
#
#   def athletic_director_setup
#     @school_id = params[:user][:athletic_director_ids]
#     if AthleticDirector.where(user_id: @user.id).present?
#       AthleticDirector.where(user_id: @user.id).last.destroy
#     end
#     AthleticDirector.create(user_id: @user.id, school_id: @school_id)
#     respond_to do |format|
#       format.js
#       format.html { redirect_to :back }
#     end
#   end
#
  
  protected
  
  def find_user
    @user = User.friendly.find(params[:id])
  end
  
end
