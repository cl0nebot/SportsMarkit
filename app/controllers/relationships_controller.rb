class RelationshipsController < ApplicationController
  before_action :find_relationship, only: [:edit, :show, :update, :destroy, :accept_user]
  
  
  def create
    @relationship = Relationship.create(user_id: params[:relationship][:user_id], team_id: params[:relationship][:team_id] )
    @team = @relationship.team
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
    if @relationship.update_attributes(relationship_params)
      respond_to do |format|
        format.html{ redirect_to team_path(@relationship.team) }
        format.json{ respond_with_bip(@relationship) }
      end
    else
      respond_to do |format|
        format.html{ render 'edit' }
        format.json{ respond_with_bip(@relationship) }
      end
    end
  end
  
  
  def destroy
  end

  def users
    
  end
  
  def accept_user
    @relationship.update_attributes(accepted: true)
    @pending_relationships = Relationship.where(team_id: @relationship.team_id, accepted: nil, rejected: nil)
    @relationships = Relationship.where(team_id: @relationship.team_id, accepted: true)
    respond_to do |format|
      format.js 
      format.html { redirect_to :back }
    end
  end
  
  protected
  
  def relationship_params
    params.require(:relationship).permit(:user_id, :team_id, :head, :head_title, :participant, :participant_classification, :position, :quote)
  end
  
  def find_relationship
    @relationship = Relationship.friendly.find(params[:id])
  end
  
  
end