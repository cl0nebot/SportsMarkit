class ConnectsController < ApplicationController
  
  def create
    ownerable_type = params[:connect][:ownerable_type]
    ownerable_id = params[:connect][:ownerable_id]
    connectable_type = params[:connect][:connectable_type]
    connectable_id = params[:connect][:connectable_id]
    @connect = Connect.create(ownerable_type: ownerable_type, ownerable_id: ownerable_id, connectable_type: connectable_type, connectable_id: connectable_id ) 
    @facilities = @connect.ownerable.facilities
    if ownerable_type == "Team"
     @team = Team.find(ownerable_id)  
    end
    
    if connectable_type == "League"
      @league = League.find(connectable_id)
    end
    
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
    @connect = Connect.find(params[:id])
    @connectable_type = @connect.connectable_type
    @connectable_id = @connect.connectable_id
    @ownerable_type = @connect.ownerable_type
    @ownerable_id = @connect.ownerable_id
    if @ownerable_type == "Team"
     @team = Team.find(@ownerable_id)  
    end
    # @league = @team_league.league
    # @team = @team_league.team
    @connect.destroy
    # @leagues = @team.leagues
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  
  def add_multiple_facilities
    object = params[:ownerable_type]
    object_id = params[:ownerable_id]
    object.constantize.find(object_id).connects.where(connectable_type: "Facility").destroy_all
    if params[:facility_ids].present?
      params[:facility_ids].each do |id|
        Connect.create(ownerable_type: object, ownerable_id: object_id, connectable_type: "Facility", connectable_id: id)
      end
    end
    @facilities = object.constantize.find(object_id).facilities
    respond_to do |format|
      format.js
      format.html
    end
  end
end
