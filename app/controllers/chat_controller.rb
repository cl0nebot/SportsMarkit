class ChatController < ApplicationController
  
  
  def index
    @team = Team.friendly.find(params[:team_id])
    
  end
  
  
end
