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
    @relationship = Relationship.find(params[:id])
    @team = @relationship.team
    @class = @relationship.class.to_s
    @id = params[:id]
    @object = @relationship
    @relationship.update_attributes(relationship_params)
    @members = @team.relationships.where(accepted: true, participant: true) + UserlessRelationship.where(team_id: @team.id, participant: true)
    staff_relationships = @team.relationships.where(accepted: true, head: true) + @team.relationships.where(accepted: true, trainer: true) + @team.relationships.where(accepted: true, manager: true)
    staff_userless_relationships = UserlessRelationship.where(team_id: @team.id, head: true) + UserlessRelationship.where(team_id: @team.id, trainer: true) + UserlessRelationship.where(team_id: @team.id, manager: true)
    @heads = staff_relationships.uniq + staff_userless_relationships.uniq
    @accepting_action = params[:relationship][:accepted].nil? ? false : true
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
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
    params.require(:relationship).permit(:user_id, :team_id, :head, :head_title, :participant, :participant_classification, :position, :quote, :username, :mobile_phone_number, :age, :nickname, :admin, :accepted, :trainer, :manager)
  end
  
  def find_relationship
    @relationship = Relationship.find(params[:id])
  end
  
  
end