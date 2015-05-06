class TeamFacilitiesController < ApplicationController
  
  
  def create
    @team_facility = TeamFacility.create(team_id: params[:team_facility][:team_id], facility_id: params[:team_facility][:facility_id])
    @facility = @team_facility.facility
    @team = @team_facility.team
    @team_facility.save
    @facilities = Team.find(@team_facility.team_id).facilities
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def destroy
    @team_facility = TeamFacility.find(params[:id])
    @facility = @team_facility.facility
    @team = @team_facility.team
    @team_facility.destroy
    @facilities = @team.facilities
    respond_to do |format|
      format.js
      format.html
    end
  end
  
end