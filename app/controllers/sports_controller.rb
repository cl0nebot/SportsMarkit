class SportsController < ApplicationController
  before_action :find_sport, only: [:show, :edit, :update, :destroy]
  
  def index
    @sports = Sport.all
    @sport = Sport.new
  end
  
  def create
    @sport = Sport.new(sport_params)
    if @sport.save
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    end
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  protected
  
  def sport_params
    params.require(:sport).permit(:sport)  
  end
  
  def find_sport
    @sport = Sport.find(params[:id])
  end
  
end
