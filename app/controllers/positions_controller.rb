class PositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  
  
  def index
    @positions = Position.all
    @position = Position.new
  end
  
  def create
    @position = Position.new(position_params)
    if @position.save
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      flash.now[:error] = @position.errors.full_messages
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    end
  end
  
  def update
    @position = Position.find(params[:id])
    @index = @position.index_position
    @before_item = @index - 1
    @result = @position.update_attributes(position_params)
    if @result
      flash[:success] = "Event Type has been updated."
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    else
      flash.now[:error] = @position.errors.full_messages
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    end
  end
  
  def destroy
    @position = Position.find(params[:id])
    @index = @position.index_position
    @position.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  
  protected
  
  def position_params
    params.require(:position).permit(:position, :sport_id, :abbreviation)
  end
end
  