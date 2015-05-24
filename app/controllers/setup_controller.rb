class SetupController < ApplicationController
  before_action :find_user, except: [:test_setup]
  
  def setup
    @athlete_teams = Team.where.not(id: @user.relationships.where(participant: true).pluck(:team_id))
    @coach_teams = Team.where.not(id: @user.relationships.where(head: true).pluck(:team_id))
    @schools = School.all - [@user.schools.last]
    @athletes = User.athletes
  end
  
  def overview
  end
  
  def test_setup
    @athletes = User.athletes
  end
  
  
  def athlete_setup
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
  
  def athletic_director_setup
    @school_id = params[:user][:athletic_director_ids]
    if AthleticDirector.where(user_id: @user.id).present?
      AthleticDirector.where(user_id: @user.id).last.destroy
    end
    AthleticDirector.create(user_id: @user.id, school_id: @school_id)
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  
  protected
  
  def find_user
    #@user = User.friendly.find(params[:id])
  end
  
end
