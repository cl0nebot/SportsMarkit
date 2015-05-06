class ParentChildrenController < ApplicationController
  
  def create
    @link = ParentChild.create(parent_id: params[:parent_child][:parent_id], child_id: params[:parent_child][:child_id])
    redirect_to :back
  end
  
  def destroy
    
  end
end
