class TournamentsController < ApplicationController
  before_action :find_tournament, except: [:index, :new, :create]
  
  def index
    @tournaments = Tournament.all
    
  end
  
  def new
    @tournament = Tournament.new
    @event = @tournament.events.build
  end
  
  def create
    #TODO director paid?
    @tournament = Tournament.new(tournament_params)
    @event = @tournament.events.last
    @event.title = params[:tournament][:name]
    @event.event_type = "Tournament"
    @event.description = params[:tournament][:description]
    if @tournament.save
      EventFacility.create(event_id: @event.id, facility_id: params[:tournament][:events_attributes]["0"][:facility_ids] )
      redirect_to @tournament
    else
      render 'new'
    end
  end
  
  def show
    @event = @tournament.events.first
    @json = @event.facility.to_gmaps4rails
  end
  
  def edit
    
  end
  
  def update
    if @tournament.update_attributes(tournament_params)
      redirect_to @tournament
    else
      render 'edit'
    end
  end
  
  def destroy
    @tournament.destroy
    redirect_to :back
    
  end
  
  protected
  
  def tournament_params
    params.require(:tournament).permit(:user_id, :name, :sport, :starts_at, :ends_at, :level, :description, :active, {events_attributes: [:id, :user_id, :starts_at, :ends_at, :created_by, :_destroy, facility_ids: []]} )
  end
  
  def find_tournament
    @tournament = Tournament.friendly.find(params[:id])
  end
  
end



#@event = @tournament.events.build(title: params[:tournament][:name], user_id: current_user.id, event_type: "Tournament", starts_at: params[:tournament][:events_attributes][:starts_at], ends_at: params[:tournament][:events_attributes][:ends_at])
