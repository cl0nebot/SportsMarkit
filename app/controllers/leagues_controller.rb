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
      redirect_to @league
    else
      render 'new'
    end
  end
  
  def show
    @object = @league
    shared_variables
    @picture =  @object.photos.build
    @teams = @league.teams
    @athletic_directors = @league.athletic_directors
    @manager_and_trainers = @league.manager_and_trainers
    @userless_managers_and_trainers = @league.userless_managers_and_trainers
    @admins = @league.admins
    @userless_admins = @league.userless_admins
    @people = @league.people
    @userless_people = @league.userless_people
    @facilities = @league.used_facilities
  end
  
  
  def edit
    @object = @league
    @picture =  @object.photos.build
    @pictures = Photo.where(photo_owner_id: @object.id, photo_owner_type: @object.class.to_s, main: false)
    profile_picture_insert
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
    params.require(:league).permit({:sport_ids => []}, :name, :description, :sport, :state, :slug, :classification, :category, :facebook, :twitter, :linkedin, :pinterest, :instagram, :foursquare, :youtube)  
  end
  
  
end