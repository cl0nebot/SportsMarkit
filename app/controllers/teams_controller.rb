class TeamsController < ApplicationController
  before_action :find_team, only: [:show, :edit, :update, :destroy]
  
  def index
    if params[:school_id]
      @school = School.friendly.find(params[:school_id])
      @teams = @school.teams.all
    else
      @teams = Team.all
    end
  end
  
  def new
    if params[:school_id]
      @school = School.friendly.find(params[:school_id])
      @team = @school.teams.build
    else
      @team = Team.new
    end
  end
  
  def create    
    if request.referrer.split("/")[3] == "schools"
      @school = School.find_by_slug(request.referrer.split("/")[4])
      @team = @school.teams.build(team_params)
      if @team.save
        redirect_to "/teams/#{@team.slug}"
      else
        render 'new'
      end
    else
      @team = Team.new(team_params)
      if @team.save
        redirect_to teams_path
      else
        render 'new'
      end
    end
  end
  
  def show
    @members = @team.relationships.where(accepted: true)
    @heads = @team.relationships.where(accepted: true, head: true)
    @class = @team.class
    @object = @team
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  protected
  
  def find_team
    @team = Team.friendly.find(params[:id])
  end
  
  def team_params
    params.require(:team).permit(:name, :sport, :school_id, :league_id)
  end
end
