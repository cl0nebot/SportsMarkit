class RelationshipsController < ApplicationController
  before_action :find_relationship, only: [:edit, :show, :update, :destroy]
  
  
  def create
    @relationship = Relationship.create(user_id: params[:relationship][:user_id], team_id: params[:relationship][:team_id] )
    @relationship.save
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def edit
    @user = User.find(@relationship.user_id)
  end
  
  def update
    @user = User.find(@relationship.user_id)
    if @relationship.update_attributes(relationship_params)
      redirect_to team_path(@relationship.team)
    else
      render 'edit'
    end
  end
  
  
  def destroy
    
    
  end
  
  protected
  
  def relationship_params
    params.require(:relationship).permit(:user_id, :team_id, :head, :head_title, :participant, :participant_classification, :position, :quote)
  end
  
  def find_relationship
    @relationship = Relationship.friendly.find(params[:id])
  end
  
  
end