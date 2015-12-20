class ConnectsController < ApplicationController
  
  def create
    object_type = params[:owner_type]
    object_id = params[:owner_id]
    connectable_type = params[:connectable_type]
    connectable_id = params[:connectable_id]
    @connect = Connect.create(owner_type: owner_type, owner_id: owner_id) 
    
    
    # @team_league = TeamLeague.create(team_id: params[:team_league][:team_id], league_id: params[:team_league][:league_id])
 #    @league = @team_league.league
 #    @team = @team_league.team
 #    @team_league.save
 #    @leagues = Team.find(@team_league.team_id).leagues
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def destroy
    @team_league = TeamLeague.find(params[:id])
    @league = @team_league.league
    @team = @team_league.team
    @team_league.destroy
    @leagues = @team.leagues
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  
  def add_multiple_facilities
    object = params[:owner_type]
    object_id = params[:owner_id]
    object.constantize.find(object_id).connects.where(connectable_type: "Facility").destroy_all
    params[:facility_ids].each do |id|
      Connect.create(owner_type: object, owner_id: object_id, connectable_type: "Facility", connectable_id: id)
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
end
