class SetupController < ApplicationController
  
  def setup
    @user = User.friendly.find(params[:id])
    @athlete_teams = Team.where.not(id: @user.relationships.where(participant: true).pluck(:team_id))
    @coach_teams = Team.where.not(id: @user.relationships.where(head: true).pluck(:team_id))
  end
  
  def overview
    @user = User.friendly.find(params[:id])
  end
  
  
  def athlete_setup
    @user = User.friendly.find(params[:id])
    @team_ids = @user.relationships.where(participant: true).pluck(:team_id)
    @adjusted_team_ids = @team_ids + params[:user][:team_ids].drop(1)
    #create relationship
    @adjusted_team_ids.each do |id|
      relationship = Relationship.find_or_create_by(user_id: @user.id, team_id: id)
      relationship.update_attributes(participant: true)
    end
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  def coach_setup
    @user = User.friendly.find(params[:id])
    @team_ids = @user.relationships.where(head: true).pluck(:team_id)
    @adjusted_team_ids = @team_ids + params[:user][:team_ids].drop(1)
    #create relationship
    @adjusted_team_ids.each do |id|
      relationship = Relationship.find_or_create_by(user_id: @user.id, team_id: id)
      relationship.update_attributes(head: true)
    end
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
end
