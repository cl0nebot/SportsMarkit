class TeamLeaguesController < ApplicationController
  
  
  def create
    @team_league = TeamLeague.create(team_id: params[:team_league][:team_id], league_id: params[:team_league][:league_id])
    @league = @team_league.league
    @team = @team_league.team
    @team_league.save
    @leagues = Team.find(@team_league.team_id).leagues
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
  
end