class LeaguesController < ApplicationController
  before_action :find_league, only: [:show, :edit, :update, :destroy]
  
  def index
    @leagues = League.all
  end
  
  def new
    @league = League.new
  end
  
  def create
    @league = League.new(league_params)
    if @league.save
      if current_user
        unless current_user.admin?
          LeagueManager.create(user_id: current_user.id, league_id: @league.id)
        end
			end
      redirect_to :back
    else
      render 'new'
    end
  end
  
  def show
    @class = @league.class
    @object = @league
    @picture =  @object.photos.build
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    @teams = @league.teams
    @videos = @league.medias.where(category: "Video")
    @articles = @league.medias.where(category: "Article")
    @fans = @league.fans
  end 
  
  def edit
    @object = @league
  end
  
  def update
    if @league.update_attributes(league_params)
      redirect_to :back
    else
      render 'edit'
    end
  end
  
  def destroy
    @league.destroy
    redirect_to :back
  end
  
  def managers
    @league_managers = LeagueManager.all
  end
  
  protected
  
  def find_league
    @league = League.friendly.find(params[:id])
  end
  
  def league_params
    params.require(:league).permit(:name, :description, :sport, :state, :slug)
  end
  
  
end